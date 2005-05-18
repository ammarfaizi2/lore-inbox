Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVERVAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVERVAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVERVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:00:11 -0400
Received: from mail.wildbrain.com ([209.130.193.228]:35493 "EHLO
	hermes.wildbrain.com") by vger.kernel.org with ESMTP
	id S262369AbVERVAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:00:02 -0400
Message-ID: <428BAB42.8030501@wildbrain.com>
Date: Wed, 18 May 2005 13:53:22 -0700
From: Gregory Brauer <greg@wildbrain.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
CC: Jakob Oestergaard <jakob@unthought.net>,
       Joshua Baker-LePain <jlb17@duke.edu>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu> <20050518202014.GZ422@unthought.net>
In-Reply-To: <20050518202014.GZ422@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-WB-MailScanner: Found to be clean
X-WB-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.599, required 5, autolearn=not spam,
	BAYES_00 -2.60)
X-MailScanner-From: greg@wildbrain.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
 > You want a few million files on the FS in order to confuse the server
 > sufficiently for it to screw up severely.

Here we reproduced the OOPS with an fresh and empty XFS volume using
the nfs_fsstress.sh script.

 > And don't run as root - common problems are also that files get wrong
 > ownership/modes (a file created by one unprivileged user shows up as
 > belonging to another unprivileged user - files can show up with modes
 > d---------)

Our nfs_fsstress.sh tests were running as root and writing only
root-owned files (with no_root_squash, of course) and reproduced
the OOPS twice.  We haven't seen the privileges problem yet.

Greg
