Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUDGNXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUDGNXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:23:24 -0400
Received: from [159.226.248.195] ([159.226.248.195]:59301 "EHLO
	dns.sinosoft.com.cn") by vger.kernel.org with ESMTP id S263457AbUDGNXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:23:15 -0400
Message-ID: <407400F1.8090809@sinosoft.com.cn>
Date: Wed, 07 Apr 2004 21:24:01 +0800
From: Gewj <geweijin@sinosoft.com.cn>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; zh-CN; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: zh-cn
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A puzzling thing about RAID5: syslogd write the log success but another
 process can not read the /var/log/messages
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hammm,tonight is funny because I got a puzzling thing just as....

my setup is a two-scsi-disk raid5 configuration...
(Linux version 2.4.18-18.7.xsmp (Red Hat Linux 7.3 2.96-112)) #1 SMP Wed
Nov 13 19:01:42 EST 2002)
it work well for a long time, but now I found some day early one of the
scsi disks failed, and I found out
that that time syslogd restarted(why??) and it could write log infor to
log file successfully.
but at the same time , another process(named such as B,run by root) can
not read
the /var/log/messages,or what's more exactly, the messages file was look
like empty to B then.
(of course, the syslogd write log infor to /var/log/messages )

I wonder that if syslogd write the log infor to the well-work scsi disk
, but the process B
read the /var/log/messages from the crashed scsi disk,which cause it
just like a empty file.

yes, it is quite unbelievable. but can some one show me a clue to this
puzzling problem?
What is the proper course of this action?










