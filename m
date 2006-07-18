Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWGRJmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWGRJmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGRJmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:42:55 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:50816 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932149AbWGRJmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:42:54 -0400
Message-ID: <44BCAD19.8070004@gmail.com>
Date: Tue, 18 Jul 2006 12:42:49 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: input/eventX permissions, force feedback
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently most distributions have /dev/input/event* strictly as 0600
root:root or 0640 root:root. The user logged in will not have rights to
the device, unlike /dev/input/js*, as he could read all passwords from
the keyboard device.

This is a problem, because /dev/input/event* is used for force feedback
and should therefore be user-accessible.

I can think of the following solutions to this problem:

1. Some creative udev rule to chmod /dev/input/event* less strictly when
it has a /dev/input/js* and is thus a gaming device.

2. Some creative udev rule to chmod /dev/input/event* more strictly when
it is a keyboard.

3. Have another force feedback interface also in /dev/input/js*.

I prefer the first one, do you think it is a good solution or do you
have a better one?

If I go with the first one, what is the preferred way of finding out a
gaming device in udev rule?


-- 
Anssi Hannula

