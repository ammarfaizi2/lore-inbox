Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSFFI5T>; Thu, 6 Jun 2002 04:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSFFI5S>; Thu, 6 Jun 2002 04:57:18 -0400
Received: from romadg-fw1.telespazio.it ([195.223.84.5]:18493 "EHLO
	ROMADG-MAIL01.telespazio.it") by vger.kernel.org with ESMTP
	id <S315287AbSFFI5S>; Thu, 6 Jun 2002 04:57:18 -0400
Message-ID: <A183DF60AC72D5119B990002A5749CB301E9C106@ROMADG-MAIL01>
From: Amici Alessandro <alessandro_amici@telespazio.it>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: device model update 2/2
Date: Thu, 6 Jun 2002 10:56:30 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

+		lock_device(dev);
+		dev->driver = NULL;
+		unlock_device(dev);
+
+		/* detach from driver */
+		if (dev->driver->remove)
+			dev->driver->remove(dev);
+		put_driver(dev->driver);

you might want to exchange these two blocks :)

regards,
alessandro
