Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWCUUw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWCUUw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWCUUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:52:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:2736 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965106AbWCUUwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:52:55 -0500
Message-ID: <442067A4.3020409@garzik.org>
Date: Tue, 21 Mar 2006 15:52:52 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, mchehab@infradead.org
Subject: DVB breaks kernel build in 2.6.16-git
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.4 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'make distclean && make allmodconfig && make -sj7' on x86-64 fails thusly:

[jgarzik@viper linux-2.6]$ make
   CHK     include/linux/version.h
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   CC [M]  drivers/media/dvb/bt8xx/bt878.o
In file included from drivers/media/dvb/bt8xx/bt878.c:46:
drivers/media/dvb/bt8xx/bt878.h:30:19: error: bt848.h: No such file or 
directorydrivers/media/dvb/bt8xx/bt878.h:31:18: error: bttv.h: No such 
file or directory
drivers/media/dvb/bt8xx/bt878.c: In function ‘bt878_device_control’:
drivers/media/dvb/bt8xx/bt878.c:353: warning: implicit declaration of 
function ‘bttv_gpio_enable’
drivers/media/dvb/bt8xx/bt878.c:359: warning: implicit declaration of 
function ‘bttv_write_gpio’
drivers/media/dvb/bt8xx/bt878.c:366: warning: implicit declaration of 
function ‘bttv_read_gpio’
drivers/media/dvb/bt8xx/bt878.c: In function ‘bt878_probe’:
drivers/media/dvb/bt8xx/bt878.c:483: error: ‘BT848_INT_MASK’ undeclared 
(first use in this function)
drivers/media/dvb/bt8xx/bt878.c:483: error: (Each undeclared identifier 
is reported only once
drivers/media/dvb/bt8xx/bt878.c:483: error: for each function it appears 
in.)
make[4]: *** [drivers/media/dvb/bt8xx/bt878.o] Error 1
make[3]: *** [drivers/media/dvb/bt8xx] Error 2
make[2]: *** [drivers/media/dvb] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

