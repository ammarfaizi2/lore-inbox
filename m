Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbUL2MSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUL2MSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUL2MSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:18:09 -0500
Received: from [219.239.36.3] ([219.239.36.3]:16058 "HELO mail.sinosoft.com.cn")
	by vger.kernel.org with SMTP id S261294AbUL2MSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:18:05 -0500
Message-ID: <41D2A05C.5020105@sinosoft.com.cn>
Date: Wed, 29 Dec 2004 21:17:32 +0900
From: Gewj <geweijin@sinosoft.com.cn>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; zh-CN; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: zh-cn
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Puzzle about the setlocale Function in Miracle3.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There has a quite strange thing about the setlocale function
in Miracle3.0
(Linux 2.4.21-9.38AX #1 Wed Nov 10 22:00:41 EST 2004 i686
glibc-common-2.3.2-95.20.1AX )

I used the following code in a daemon program and start it in rc3.d

	setlocale(LC_ALL, "ja_JP");
	bindtextdomain("express", "/usr/local/mo");
	textdomain("express");
        //get string from .mo file according to the locale set
        strcpy(myString,gettext("MyID"));

the dir structure of /usr/local/mo is list below:

/usr/local/mo
           -|en_US
                 -|LC_MESSAGES
           -|ja_JP
             -|LC_MESSAGES


where I reboot the machine, gettext("MyID") return its string defined in
 en_US .mo file instead of in ja_JP .mo file
But where I restart the same daemon program after reboot , the same
program works OK.

Can anyone show me some tips to the reason?

thanks in advance.

Gewj.



