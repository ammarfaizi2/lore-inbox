Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274496AbRJACmJ>; Sun, 30 Sep 2001 22:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274497AbRJAClu>; Sun, 30 Sep 2001 22:41:50 -0400
Received: from zok.SGI.COM ([204.94.215.101]:48008 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274496AbRJAClj>;
	Sun, 30 Sep 2001 22:41:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot unload some modules 
In-Reply-To: Your message of "Thu, 27 Sep 2001 15:54:19 +0200."
             <E15mbcJ-0001Hd-00@DervishD> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Oct 2001 12:41:51 +1000
Message-ID: <13500.1001904111@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001 15:54:19 +0200, 
=?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas Coronado <dervishd@jazzfree.com> wrote:
>    I have a problem with some modules, specially with 'dummy.o' (the
>dummy network device driver) and some USB ones: they aren't unloaded,
>even when unused and autocleanable, issuing two or more 'rmmod -a'
>commands.

Auto unload ignores modules that have not been used, to avoid a race
condition.  Either use the module or don't auto load them in the first
place.

>    BTW, I've noticed too that the serial module sometimes has a
>negative value in its 'use' count :!!

That could be the serial driver saying that it handles its own unload
count but is more likely to be a bug in the code.  Report it to the
serial driver maintainer.

