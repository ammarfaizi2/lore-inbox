Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbULYWSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbULYWSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 17:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbULYWSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 17:18:21 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:28271 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261580AbULYWSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 17:18:18 -0500
Message-ID: <41CDE70E.8090109@yahoo.com>
Date: Sat, 25 Dec 2004 14:17:50 -0800
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 breaks xconsole
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running kernel 2.6.10, xconsole always displays: Couldn't open console.
xconsole works fine in the identical setup with 2.6.9 and 2.4.28.

The permissions are set correctly:
crw-rw-r--  1 lars tty 5, 1 2004-12-25 13:17 /dev/console

xconsole won't work when run as either lars, a tty member, and even 
root. In all cases the message above is shown.

If I change permission to:
crw-rw-r--  1 root tty 5, 1 2004-12-25 13:17 /dev/console

xconsole can at least be run as root.

I guess this is related to this patch:
<od@suse.de>
	[PATCH] TIOCCONS security

Forcing xconsole to be run as root is not a good idea, IMHO.

-- Lars

ps. Please CC me directly as I'm not subscribed to the list.
