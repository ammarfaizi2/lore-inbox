Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRJQCRo>; Tue, 16 Oct 2001 22:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273918AbRJQCRe>; Tue, 16 Oct 2001 22:17:34 -0400
Received: from rj.sgi.com ([204.94.215.100]:23464 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274055AbRJQCRQ>;
	Tue, 16 Oct 2001 22:17:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols??? 
In-Reply-To: Your message of "Tue, 16 Oct 2001 09:27:55 MST."
             <Pine.LNX.4.33.0110160927030.24895-100000@devel.office> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Oct 2001 12:17:39 +1000
Message-ID: <30375.1003285059@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001 09:27:55 -0700 (PDT), 
Christoph Lameter <christoph@lameter.com> wrote:
>I just tried to load the loop driver in 2.4.11
>
>devel:/home/christoph/devel/bf/boot-floppies# insmod loop
>Using /lib/modules/2.4.11/kernel/drivers/block/loop.o
>/lib/modules/2.4.11/kernel/drivers/block/loop.o: unresolved symbol
>invalidate_bdev
>/lib/modules/2.4.11/kernel/drivers/block/loop.o: Note: modules without a
>GPL compatible license cannot use GPLONLY_ symbols
>
>What is THAT?

If a symbol has been exported with EXPORT_SYMBOL_GPL then it appears as
unresolved for modules that do not have a GPL compatible MODULE_LICENCE
string.  So when a module without a GPL compatible MODULE_LICENCE gets
an unresolved symbol, I print that message as a hint to the user.  I
thought the response was obvious, but looks like I need to expand the
hint text even further.

Note: modules without a GPL compatible license cannot use GPLONLY_ symbols.
      This may or may not be your problem, there can be other reasons
      for unresolved symbols.

