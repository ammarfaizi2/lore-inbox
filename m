Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDHVE4 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTDHVE4 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:04:56 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:10471 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S261743AbTDHVEz (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:04:55 -0400
Subject: Re: 2.5.67 kernel BUG at fs/buffer.c:2538
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1049815653.32665.1135.camel@spc9.esa.lanl.gov>
References: <1049815653.32665.1135.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1049836574.32480.1156.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 08 Apr 2003 15:16:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 09:27, Steven Cole wrote:
> This may be a case of:
> 
> "It hurts when I do this:"
> "Then don't do that!"
> 
> I started the latest security updated package of samba with
> kernel 2.5.67, but I had forgotten to set CONFIG_SMB_FS.
> The box became unresponsive, and then locked hard. Didn't respond
> to pings, etc.  So I had to alt-sysrq-b. Now, samba is broken somehow, 
> ERROR: Samba cannot create a SAM SID.
> so I can't presently retest with SMB_FS=y and 2.5.67 or with
> the vendor kernel (2.4.21-0.13mdk).  Unfortunately I had not yet 
> tested the new security updated packages for samba with the vendor kernel.
> 
> However dumb it was to start samba without SMB_FS enabled,
> the box shouldn't die like this.
> 
> I'm going to replace Bamboo with Shrike on that machine today,
> so I won't be able to reproduce this anytime soon. (I hope).
> 
Replying to myself with an update.  After reading the fs/Kconfig help
for SMB_FS I now realize that having that compiled in or not was 
orthogonal to starting the samba server.

I installed Redhat 9 (Shrike) on the test box, and tested samba with
both the vendor kernel and 2.5.67 (with and without SMB_FS before I
realized that was not the issue).  It all worked.  Then I upgraded
the samba packages (security updates) and tested everything again, and
it still all works. 

I cannot reproduce the kernel BUG at fs/buffer.c:2538, at least not yet.

Steven

