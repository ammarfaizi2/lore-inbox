Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWH1Ifo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWH1Ifo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWH1Ifo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:35:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29909 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751288AbWH1Ifn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:35:43 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Subject: Re: Linux v2.6.18-rc5 
In-reply-to: Your message of "Sun, 27 Aug 2006 23:14:21 MST."
             <20060827231421.f0fc9db1.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Aug 2006 18:34:56 +1000
Message-ID: <13331.1156754096@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Sun, 27 Aug 2006 23:14:21 -0700) wrote:
>(Reporters Bcc'ed: please provide updates)
>
>Serious-looking regressions include:
>From: Keith Owens <kaos@ocs.com.au>
>Subject: 2.6.18-rc4 Intermittent failures to detect sata disks

Two hours of continuous reboots on an ICH5 chipset passed without any
problems.  Couple of caveats though -

(1) The "fix" for this bug is to skip the pcs test for SATA ports on
    ICH5 chipsets.  This results in spurious warning messages for ICH5
    SATA ports with no disks attached.

    ATA: abnormal status 0x7F on port 0xCCA7

(2) I have seen the same intermittent bug on ICH7 SATA but
    PIIX_FLAG_IGNORE_PCS is only set for ich5 and i6300esb_sata.  It
    probably needs to be set for ich7 as well.

