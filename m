Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVEYFPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVEYFPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVEYFPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:15:40 -0400
Received: from jade.aracnet.com ([216.99.193.136]:46747 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S262270AbVEYFPe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:15:34 -0400
From: van <van.wanless@eqware.net>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 3.3 (2110) - Licensed Version
Date: Tue, 24 May 2005 22:15:31 -0700
Message-ID: <2005524221531.650853@Oz>
Subject: File I/O from within a driver
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...
 
I am currently writing a driver for a hardware codec accelerator.  The calling application will open a media file, write to the codec driver, and read frames back from the codec driver.  My issue comes with the read of the media file.  The structure of media files is complex and I'd rather the calling application didn't need to have any knowledge of that structure.  But how can the driver do the necessary read() operations?
 
I could, for example, have the application pass an open file descriptor in to my driver via an ioctl() call; if I understand matters correctly, my driver could then call sys_read().  I've never done anything like that before, never expected to need to, and it doesn't feel right.
 
Can anyone suggest the *proper* way to accomplish this?
 
I am not a member the list list; I hit the weeklies pretty frequently, but I'd appreciate it any responders would CC me directly at van.wanless@eqware.net.   Thanks.
 
--Van Wanless
EQware Engineering, Inc.
van.wanless@eqware.net

