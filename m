Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271107AbTGXHn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 03:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271127AbTGXHn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 03:43:59 -0400
Received: from hacksaw.org ([216.41.5.170]:55188 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id S271107AbTGXHn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 03:43:58 -0400
Message-Id: <200307240759.h6O7x5sV023863@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4
To: cijoml@volny.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling 
In-reply-to: Your message of "Thu, 24 Jul 2003 09:16:17 +0200."
             <200307240916.17530.cijoml@volny.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Jul 2003 03:59:05 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maybe there should be a possibility in menuconfig and xconfig for users
>specify their own compiler options.

The system does take the chip into account, as far as I remember. It's one of 
the first few options of the config system.

As to the -O4 option, it's important to think about what optimizations it's 
doing. Many of the critical functions in the kernel are hand coded assembler, 
no small amount of work. The other functions might gain from this, but I bet 
they don't. They might even lose from it.

In any case it appears that if you modify the HOSTCFLAGS in the top level 
Makefile, you can add these options. Do be careful. The data you save may be 
your own.
-- 
A principle is universal.
A rule is specific.
A law is invariable.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


