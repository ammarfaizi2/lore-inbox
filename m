Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUBQHoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUBQHoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:44:10 -0500
Received: from hera.kernel.org ([63.209.29.2]:5844 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262598AbUBQHoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:44:04 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 and case-insensitivity
Date: Tue, 17 Feb 2004 07:43:40 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0sgnc$ngo$1@terminus.zytor.com>
References: <16433.38038.881005.468116@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1077003820 24089 63.209.29.3 (17 Feb 2004 07:43:40 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 17 Feb 2004 07:43:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16433.38038.881005.468116@samba.org>
By author:    tridge@samba.org
In newsgroup: linux.dev.kernel
>
> Given how much pain the "kernel is agnostic to charset encoding"
> attitude has cost me in terms of programming pain, I thought I should
> de-cloak from lurk mode and put my 2c into the UTF-8 issue.
> 
> Personally I think that eventually the Linux kernel will have to
> embrace the interpretation of the byte streams that applications have
> given it, despite the fact that this will be very painful and
> potentially quite complex. The reason is that I think that eventually
> the Linux kernel will need to efficiently support a userspace policy
> of case-insensitivity and the only way to do case-insensitive filename
> operations is to interpret those byte streams as a particular
> encoding.
> 

Realistically, the only sane way to do this is to set our foot down
and say: UTF-8 is *the* encoding.  A good step in that direction would
be to set utf-8 to be the default NLS in the kernel, but as long as
people keep the whole sick idea that we can continue to use
locale-dependent encoding we're in for a world of hurt.

That's really the long and short of it.  Until people are willing to
say "we support UTF-8, anything else and it's anyone's guess what
happens" then nothing is going to happen.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
