Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVDMVA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDMVA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDMVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 17:00:28 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:1240 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261200AbVDMVAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 17:00:22 -0400
X-Mailer: exmh version 2.7.2 04/02/2003 (gentoo 2.7.2) with nmh-1.1
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support... 
In-reply-to: <20050413193924.GN521@csclub.uwaterloo.ca> 
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org> <20050413183722.GQ17865@csclub.uwaterloo.ca> <20050413190756.54474240480@latitude.mynet.no-ip.org> <20050413193924.GN521@csclub.uwaterloo.ca>
Comments: In-reply-to lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
   message dated "Wed, 13 Apr 2005 15:39:24 -0400."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Apr 2005 22:59:49 +0200
From: aeriksson@fastmail.fm
Message-Id: <20050413205949.E987A240480@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 13, 2005 at 09:07:56PM +0200, aeriksson@fastmail.fm wrote:
> growisofs -Z /dev/hdc -J -R /path/to/dir/with/less/than/4.5GB/of/files
> 
> That should do it.  To do scsi I suspect it would be /dev/sg0 or
> /dev/scd0.  I haven't actually tried burning in scsi emulation mode with
> these drives.
> 
Nope. No go. The kernel log getsb these 4 lines:
Apr 13 22:08:30 tippex SCSI error : <0 0 0 0> return code = 0x8000002
Apr 13 22:08:30 tippex sr0: Current: sense key: Medium Error
Apr 13 22:08:36 tippex SCSI error : <0 0 0 0> return code = 0x8000002
Apr 13 22:08:36 tippex sr0: Current: sense key: Medium Error

and the application bails out with:
:-[ WRITE@LBA=0h failed with SK=5h/ASC=30h/ACQ=05h]: Wrong medium type
:-( media is not formatted or unsupported.
:-( write failed: Wrong medium type

This is with a fresh from the box DVD-RW. Do I need to 'format' the
thing before writing to it? This is getting tricky... Are these kind
of errors normally indicative of lack of support or a faulty unit?
I have no windows around to test it with the shipped nero-cd :-(

/Anders


