Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266393AbRGBHWk>; Mon, 2 Jul 2001 03:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266394AbRGBHWa>; Mon, 2 Jul 2001 03:22:30 -0400
Received: from imladris.infradead.org ([194.205.184.45]:13075 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S266393AbRGBHWT>;
	Mon, 2 Jul 2001 03:22:19 -0400
Date: Mon, 2 Jul 2001 08:22:07 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <rmk@arm.linux.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <22864.994042106@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0107020818190.18977-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith, Adam.

 >> Does anyone know if there is any code that would break if we
 >> put quotation marks around the $CONFIG_xxxx references in the
 >> dep_xxx commands in all of the Config.in files?

 > That has the same problem that AC was worried about.  Variables
 > that used to be treated as "undefined, don't care" are now
 > treated as "undefined, assume n and forbid".

Whilst there could easily be problems if we allow that for any of the
variables, it can't be a problem if we restrict it to variables
specifying the architecture in question, as per my previous email.

 > As long as there is any ambiguity about how a rule is meant to
 > treat undefined variables, treating all undefined variables as
 > 'n' is not safe.  Before making a global change like this, first
 > verify that no rule treats undefined variables as "don't care".
 > Otherwise something will break.

Agreed.

Best wishes from Riley.

