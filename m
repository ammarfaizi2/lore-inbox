Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSELXBP>; Sun, 12 May 2002 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315452AbSELXBO>; Sun, 12 May 2002 19:01:14 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32014 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315449AbSELXBN>;
	Sun, 12 May 2002 19:01:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA 
In-Reply-To: Your message of "Sun, 12 May 2002 20:36:15 +0200."
             <20020512203615.A12612@averell> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 May 2002 09:01:00 +1000
Message-ID: <25899.1021244460@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 20:36:15 +0200, 
Andi Kleen <ak@muc.de> wrote:
>This patch make CONFIG_ISA an configuration option for i386. This makes
>sense considering that most PCs do not ship with ISA slots anymore.

make xconfig
drivers/ide/Config.in: 129: can't handle dep_bool/dep_mbool/dep_tristate condition

Your dep_* conditions are wrong.  The conditional fields require
$CONFIG, not a bare CONFIG.

Always check config changes under both oldconfig and xconfig.  xconfig
is the only CML1 code that does a full syntax check, the other CML1
*config rules silently ignore many syntax errors.

