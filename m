Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSGDW3z>; Thu, 4 Jul 2002 18:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGDW3y>; Thu, 4 Jul 2002 18:29:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:63496 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315276AbSGDW3y>;
	Thu, 4 Jul 2002 18:29:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: writing to serial console 
In-reply-to: Your message of "Thu, 04 Jul 2002 10:14:50 EST."
             <20020704151450.75171.qmail@mail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jul 2002 08:32:16 +1000
Message-ID: <17985.1025821936@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jul 2002 10:14:50 -0500, 
"Lee Chin" <leechin@mail.com> wrote:
>I'm trying to write status messages to the serial console as the kernel boots up.  I tried writing to ttyS0 in main.c, but the kernel crashes with a paging violation.  Is there an easy way to do this?

printk() and a serial console.  Console output does not occur until
console_init().  To debug problems that occur before console_init(),
see these patches.

http://marc.theaimsgroup.com/?l=linux-kernel&m=101072840225142&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=102386369913669&w=2

