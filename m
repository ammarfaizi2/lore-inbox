Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUCDWiG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUCDWiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:38:05 -0500
Received: from pop.gmx.de ([213.165.64.20]:13487 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261995AbUCDWiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:38:03 -0500
X-Authenticated: #217404
Message-Id: <6.0.0.22.0.20040304233359.02c81690@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Thu, 04 Mar 2004 23:39:18 +0100
To: linux-kernel@vger.kernel.org
From: Dennis Lubert <plasmahh@gmx.net>
Subject: Small bug in include/scsi/scsi.h of 2.6.x
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I probably found a small bug in the include/scsi/scsi.h of the 2.6.x 
series. I came over this when trying to compile program(s) with scsi 
support. They were complaining about u8 beeing undefined, or errors at this 
point. Now u8 is defined in linux/types.h but included in #ifdefs for 
kernel, so that in scsi.h it is only defined when compiling within kernel.
So I assume the best is to replace all u8 in scsi.h with __u8 which is also 
defined in "user" case. At least I did, and it compiled fine, and still 
works fine.

greets

Dennis

Carpe quod tibi datum est 

