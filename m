Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTIDJHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTIDJHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:07:20 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:13775 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264812AbTIDJHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:07:16 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Call of tty->driver.write provides segmentation fault
Date: Thu, 4 Sep 2003 11:07:11 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309041107.12393.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently contriving a network driver using the serial port.
I've created my own line discipline (and tests prove it reads well), but I
can't write to the port : I tried to use tty->driver.write(tty, 0, msg,
strlen(msg)) (the same way that in printk.c, i.e. after testing that
tty->driver.write exists) but it crashs into a segmentation fault.
Since the driver implementation is not mine (I'm just using the serial
module), I can't check the function's address, but I believe the tty is ok (it 
is the same I use for the line discipline).

Does anyone know in which way I can search a solution ?
Thanks,
-- 
Laurent Hugé.

