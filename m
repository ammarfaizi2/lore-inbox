Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbSLSFF2>; Thu, 19 Dec 2002 00:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbSLSFF1>; Thu, 19 Dec 2002 00:05:27 -0500
Received: from h011.c007.snv.cp.net ([209.228.33.239]:30399 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S267535AbSLSFF0>;
	Thu, 19 Dec 2002 00:05:26 -0500
X-Sent: 19 Dec 2002 05:13:27 GMT
Message-ID: <001501c2a71c$bd043e50$9900a8c0@Scottlaptop>
From: "Scott Nash" <ksnash@directvinternet.com>
To: <linux-kernel@vger.kernel.org>
Subject: char device kernel module won't write
Date: Wed, 18 Dec 2002 23:08:58 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to finish a driver to write to a small lcd screen.  I can write
to the screen all day but I need to get the write function to work.  This is
under kernel 2.2.16-22.  I started with the tagged fops set up.  Then to see
if it made a difference I fully declared the fops structure making sure all
the positions were acounted for with NULL or fuction call.  I basically have
nothing but open, release, read, write and llseek defined.  I selected a
major of 200 after not seeing it defined.  The device loads fine.  I made a
test program for it, which opens the device, writes one line and then
closes.  When I try to write,in the test, the debug statements for read
function come up and I get an oops.
Everything says that the write I wrote and placed in fops structure should
be called.  What I am trying to write to device is: struct lcdpacket{int
line;char text[18]};
I have tried to change places of read and write but those incompatible
pointers keep coming up.
I am debating on going on list, but please cc me right now.

