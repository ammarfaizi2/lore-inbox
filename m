Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTKNNpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 08:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTKNNpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 08:45:51 -0500
Received: from main.gmane.org ([80.91.224.249]:21198 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262564AbTKNNpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 08:45:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 13:46:51 -0000
Message-ID: <bp2mab$sts$1@sea.gmane.org>
References: <20031114113224.GR21265@home.bofhlet.net>
X-Complaints-To: usenet@sea.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> FAT: Bogus number of reserved sectors
>> VFS: Can't find a valid FAT filesystem on dev sda

>Oh, no, not again... :(

>We had the same problem few weeks ago... a patch is in the archives, it
>worked for me.

I did apply Andries's 'Relax FAT checking' patch last night but the only
difference I noticed was my belkin reader changed it's error to 'no media
found' the camera still gave 'wrong fs...'

After advice from Philippe and Andries and the following I found on a
website;
"The problem is that Linux only looks at the disk geometry the first time
the camera is plugged in. So when you unplug the camera and change the
memory card Linux does not check to see if the geometry has changed."

I really hope I've not chased my tail by hitting the following combination
'up-patched inode.c' + 'trying to use sda after a deja search' and finally
'Linux only checking the geometry once'. I'd like to put this thread on hold
until I take stock of the steps I've taken just to make sure I've not been a
right 'plum'.

--
Patrick



