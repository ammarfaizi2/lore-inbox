Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbSKVUVs>; Fri, 22 Nov 2002 15:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSKVUVs>; Fri, 22 Nov 2002 15:21:48 -0500
Received: from mail.webmaster.com ([216.152.64.131]:41104 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S262800AbSKVUVq> convert rfc822-to-8bit; Fri, 22 Nov 2002 15:21:46 -0500
From: David Schwartz <davids@webmaster.com>
To: <gianni@ecsc.co.uk>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 22 Nov 2002 12:28:54 -0800
In-Reply-To: <1037966789.6079.33.camel@lemsip>
Subject: Re: TCP memory pressure question
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021122202855.AAA322@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Nov 2002 12:06:29 +0000, Gianni Tedesco wrote:

>On Thu, 2002-11-21 at 21:34, David Schwartz wrote:

>>    When a Linux machine has reached the tcp_mem limit, what will happen to
>>'write's on non-blocking sockets? Will they block until more TCP memory is
>>available? Will they return an error code? ENOMEM?

>from write(2) man page.

>EAGAIN Non-blocking I/O has been selected using O_NONBLOCK and the write
>would block.

	So this would be a case where 'poll' or 'select' would return a write hit 
for a socket but 'write' would return -1 and set errno to EAGAIN.

	DS


