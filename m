Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTLHTcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLHTcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:32:54 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:24471 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261575AbTLHTcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:32:51 -0500
Message-ID: <3FD4D103.2080007@nucleodyne.com>
Date: Mon, 08 Dec 2003 11:29:07 -0800
From: "NucleoDyne Systems Inc." <nucleon@nucleodyne.com>
Organization: www.NucleoDyne.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lost SCSI IO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been developing a SCSI based application and facing hardship due 
to lack of  better debugging support in SCSI domain on linux. May be I 
am not very familiar with linux scsi subsystem.

 I have a lost IO, sitting somewhere in some queue. The scsi logging 
facility has been turned on with : echo "scsi log all" > /proc/scsi/scsi.

The syslog shows that the request has started:
scsi_do_req (host = 0, channel = 0 target = 3, buffer =00000000, bufflen 
= 0, d)command : 00  20  00  00  00  00
Leaving scsi_do_req()

The SCSI bus trace does not show any activity.

I guess only way to find out the state of the IO is to put printf and 
recompile the kernel. HP-UX had facilities like  lkcd, linux crash dump 
analyzer. I used to be called q4. A perl script could be written to 
navigate kernel data structures and extract information from them on a 
running system. If we had that kind of tool already into linux then 
debugging the live system would be easier.

Is there a plan to include lkcd into  default kernel?



