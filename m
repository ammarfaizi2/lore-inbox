Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277235AbRJLFYv>; Fri, 12 Oct 2001 01:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277232AbRJLFYm>; Fri, 12 Oct 2001 01:24:42 -0400
Received: from web15001.mail.bjs.yahoo.com ([61.135.128.4]:45322 "HELO
	web15001.mail.bjs.yahoo.com") by vger.kernel.org with SMTP
	id <S277228AbRJLFY2>; Fri, 12 Oct 2001 01:24:28 -0400
Message-ID: <20011012052453.72507.qmail@web15001.mail.bjs.yahoo.com>
Date: Fri, 12 Oct 2001 13:24:53 +0800 (CST)
From: =?gb2312?q?hanhbkernel?= <hanhbkernel@yahoo.com.cn>
Subject: initrd problem of 2.4.10
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no problem using the initial RAM disk
(initrd) with kernel 2.4.9
But with kernel 2.4.10 system reports the following
messages:

RAMDISK: compressed image found at block 0
Freeing initrd memory: 1153k freed
VFS: Mounted root (ext2 filesystem)
Freeing unused kernel (memory: 224k freed)
Kernel panic: No init found. Try passing init=option
to kernel

When I compile the 2.4.10 The following option is
supported:
<*> RAM disk support(128000)   Default RAM disk size  
                           
[*]   Initial RAM disk (initrd) support   

The version of lilo is 21.6. My lilo.conf is as this:
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
linear
default=CapitelFW-2.4.9
image=/hda2/boot/linux-2.4.91
	label=CapitelFW-2.4.9
	initrd=/hda2/root/initrd.gz
	append="root=/dev/ram0 init=linuxrc rw"
image=/hda2/boot/linux-2.4.10-ac
	label=CapitelFW-ac12
	initrd=/hda2/root/initrd.gz
	append="root=/dev/ram0 init=linuxrc rw"



_________________________________________________________
Do You Yahoo!? 登录免费雅虎电邮! http://mail.yahoo.com.cn

<font color=#6666FF>无聊？郁闷？高兴？没理由？都来聊天吧！</font>—— 
雅虎全新聊天室! http://cn.chat.yahoo.com/c/roomlist.html
