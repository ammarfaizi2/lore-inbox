Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbTIDStl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265496AbTIDStl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:49:41 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:35718 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265493AbTIDSti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:49:38 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re : Call of tty->driver.write provides segmentation fault
Date: Thu, 4 Sep 2003 20:49:37 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200309041107.12393.laurent.huge@wanadoo.fr> <200309041335.14730.laurent.huge@wanadoo.fr> <20030904124138.B8414@flint.arm.linux.org.uk>
In-Reply-To: <20030904124138.B8414@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309042049.37825.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 4 Septembre 2003 13:41, Russell King a écrit :
> If that's the case, I can't help you.  If the kernel isn't oopsing, then
> it isn't the call to tty->driver.write which is causing your problem -
> it must be an error in the userspace program.
Ok, at least, I learned one thing !
Eventually, I've found a workaround ; I've been taught that I can write 
directly at the serial port address (I tought it wasn't permitted by the 
serial module), so that's what I do since I've got to send only one caracter 
(sort of acknowledge).
Now I'm trying to find out why the tcsetattr of my termios configuration fails 
(the thing work at 9600 bauds but not at 115200).
Thanks,
-- 
Laurent Hugé.

