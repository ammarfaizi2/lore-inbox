Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267098AbUBMRMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267128AbUBMRMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:12:32 -0500
Received: from hera.kernel.org ([63.209.29.2]:55973 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267098AbUBMRMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:12:30 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Initrd Question
Date: Fri, 13 Feb 2004 17:12:05 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0j0h5$ms8$1@terminus.zytor.com>
References: <1oMkR-1Zk-21@gated-at.bofh.it> <E1ArfAQ-00007f-7Z@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076692325 23433 63.209.29.3 (13 Feb 2004 17:12:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 13 Feb 2004 17:12:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E1ArfAQ-00007f-7Z@localhost>
By author:    der.eremit@email.de
In newsgroup: linux.dev.kernel
> 
> Now you're saying the kernel ignores real-root-dev, while a moment
> before you state that it is important to set real-root-dev because
> otherwise the kernel does something. Which is it?
> 

You have to set root=/dev/ram0 in the boot loader, so that the kernel
will spawn /sbin/init with pid 1.  Otherwise it spawns /linuxrc with a
non-1 pid, for dumb historical reasons.

Thus, setting it in the script is too late to do any good.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
