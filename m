Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUHJPCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUHJPCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUHJPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:02:35 -0400
Received: from web12506.mail.yahoo.com ([216.136.173.198]:10140 "HELO
	web12506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266258AbUHJPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:02:32 -0400
Message-ID: <20040810150232.3937.qmail@web12506.mail.yahoo.com>
Date: Tue, 10 Aug 2004 08:02:32 -0700 (PDT)
From: Chirag Pandya <searchformehere@yahoo.com>
Subject: Compiling External Modules - Local Include Files
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble recompiling my 2.4 modules that
contain local include files.  Here is the scenario:
Dir contents
------------
/home/radar/dirA/local.h
/home/radar/dirB/main.c
/home/radar/dirB/Makefile

main.c
------
#include "dirA/local.h"
main ()
{
/* Module Code*/
}

Using the following make command
# make -C /usr/src/linux-2.6.7 M=$(PWD) modules

I get the following error messages
Entering directory /usr/src/linux-2.6.7
CC [M] /home_dir/dirB/main.c:15:32: dirA/local.h: No
such file or directory

Obviously when I am in /usr/src/linux-2.6.7 I cannot
see local.h.

I noticed that PATCH 5/5 contains an extmodules.txt
document with but with a "local includes" section
still blank under TODO. 

Any help on how I can fix this?
Thanks




		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
