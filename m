Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRJQTMR>; Wed, 17 Oct 2001 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277064AbRJQTMH>; Wed, 17 Oct 2001 15:12:07 -0400
Received: from doorbell.lineo.com ([204.246.147.253]:29922 "EHLO
	thor.lineo.com") by vger.kernel.org with ESMTP id <S277065AbRJQTLy>;
	Wed, 17 Oct 2001 15:11:54 -0400
Message-ID: <3BCDE77F.D1B164A@lineo.com>
Date: Wed, 17 Oct 2001 13:18:07 -0700
From: pierre@lineo.com
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack wrote: 
> > Then do not output such a message. This is not
> > M$ windows.
> >
> And how do you expect them to find all of the
> modules that don't have MODULE_LICENCE if they
> can't see an indicator in the boot messages?

The kernel doesn't actually do anything with the
"tainted" flag, insmod does. So you have to compile
things as module and insmod them, and insmod will
dump a message if the MODULE_LICENSE thing isn't
in the module. If you compile things inside the
kernel instead of modules, you will see nothing and
/proc/sys/kernel/tainted will contain 0, which
is wrong.

--------------------------------------
Pierre-Philippe Coupard
Senior Software Engineer, Lineo, Inc.
(801) 426-5001 x 208
--------------------------------------
