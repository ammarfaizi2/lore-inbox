Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSKKVoV>; Mon, 11 Nov 2002 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSKKVoV>; Mon, 11 Nov 2002 16:44:21 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:640 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S261370AbSKKVoU>; Mon, 11 Nov 2002 16:44:20 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: how to export a symbol so that I can use it in a module
Date: Mon, 11 Nov 2002 22:54:23 +0100
Message-ID: <002c01c289cc$e6468470$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've added a function "create_tcp_port_number" to net/core/utils.c
like this:

int create_tcp_port_number(void)
{
/* blah blah */
}
EXPORT_SYMBOL(create_tcp_port_number);

in include/linux/net.h I added:
extern int create_tcp_port_number(void);

So, now in net/ipv6/tcp_ipv6.c I used this 'create_tcp_port_number'
function. I'm compiling the kernel with ipv6 as a module. And that's
where I get the problem. In the last stage, the makefile does a
depmod and then I get:
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/net/ipv6/ipv6.o
depmod:         create_tcp_port_number

I'm really out of ideas what can be the cause of this. It must be
something trivial, but I cannot find the solution. Anyone who can
help me?

Thank you.


Folkert van Heusden

