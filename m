Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272309AbTHIKTm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272316AbTHIKTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:19:42 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:63104 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S272309AbTHIKTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:19:40 -0400
Message-ID: <3bba01c35e5f$ba01f3a0$97ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: lost mouse  synchronization after apm-suspend
Date: Sat, 9 Aug 2003 19:13:17 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Greg KH" <greg@kroah.com> wrote to someone else:

> Unload all usb drivers before suspending please.

I hope this isn't a general rule?  I can't keep up with the list, but I saw
this message, and it looks like a disaster.

There are a lot of small-size desktop machines that depend on USB keyboards
because they don't have PS/2 ports.  In some cases the keyboard includes a
PS/2 hub for a PS/2 mouse, but in some cases the keyboard doesn't even have
that so the mouse is also USB.  In all of these cases the connection to the
CPU goes through a USB port.

How should the user restore their keyboard after resuming from suspend?  A
modprobe or insmod command?  In the vast majority of these cases the input
of a command would depend on having the USB keyboard already working.

