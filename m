Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUBKXyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUBKXyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 18:54:09 -0500
Received: from hera.kernel.org ([63.209.29.2]:44984 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265765AbUBKXyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 18:54:05 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: printk and long long
Date: Wed, 11 Feb 2004 23:53:57 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0efal$qfp$1@terminus.zytor.com>
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua> <yw1xvfmdwe4s.fsf@kth.se> <je8yj9cl27.fsf@sykes.suse.de> <yw1xn07pw6sy.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076543637 27130 63.209.29.3 (11 Feb 2004 23:53:57 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 11 Feb 2004 23:53:57 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <yw1xn07pw6sy.fsf@kth.se>
By author:    mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
In newsgroup: linux.dev.kernel
>
> Andreas Schwab <schwab@suse.de> writes:
> 
> > mru@kth.se (Måns Rullgård) writes:
> >
> >> What is the proper way to deal with printing an int64_t when int64_t
> >> can be either long or long long depending on machine?
> >
> > PRId64 from <inttypes.h> (replace d with the desired format character).
> > This is for user space, not sure whether that is acceptable for kernel
> > code (<intttypes.h> is not one of the required headers for freestanding
> > implementations).
> 
> That should work for userspace.  What standard specifies those?
> What about kernel sources?
> 

C99 defines those.

Another (frequently easier) way is to cast to (intmax_t) and use the %j size modifier:

	printf("foo = %jd\n", (intmax_t)foo);

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
