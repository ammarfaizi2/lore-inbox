Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSANSuw>; Mon, 14 Jan 2002 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSANSuf>; Mon, 14 Jan 2002 13:50:35 -0500
Received: from ausxc07.us.dell.com ([143.166.227.166]:7739 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S288834AbSANSu0>; Mon, 14 Jan 2002 13:50:26 -0500
Message-ID: <71714C04806CD5119352009027289217022C423B@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Subject: struct gendisk max_p gone in 2.5.x
Date: Mon, 14 Jan 2002 12:49:51 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The max_p member of struct gendisk was deleted in 2.5.x.  Is there a
different preferred method for partition detection code to know the maximum
number of partitions it's allowed to present?  Previously I was using this
field in the GPT detection code to only present the first max_p partitions
(because GPT allows an unlimited number of partitions).  For SCSI disks with
the current major/minor numbering scheme, it shouldn't create more than 15
partitions; for IDE, 63.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)
