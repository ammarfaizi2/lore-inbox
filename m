Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267653AbSKTHdL>; Wed, 20 Nov 2002 02:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSKTHc0>; Wed, 20 Nov 2002 02:32:26 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:47378
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265890AbSKTHa5>; Wed, 20 Nov 2002 02:30:57 -0500
Subject: Re: spinlocks, the GPL, and binary-only modules
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DDAB6AD.4050400@pobox.com>
References: <3DDAB6AD.4050400@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037777880.26594.5.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 23:38:00 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 14:09, Jeff Garzik wrote:
> blah.
> 
> So, since spinlocks and semaphores are (a) inline and #included into 
> your code, and (b) required for just about sane interoperation with Linux...
> 
> does this mean that all binary-only modules that #include kernel code 
> such as spinlocks are violating the GPL?  IOW just about every binary 
> module out there, I would think...

There are a whole pile of rules and precedents over this.  For one, a
certain code size limit applies, as does the notion of whether there's
any creative input (for example, constants and structure definitions are
not considered creative, because they are simply required for an
interface to work).

One argument is that since the interfaces require you to manipulate the
locks in a particular way, and only a given set of instructions will do
those manipulations correctly, then any correct implementation will
contain those instructions.  Whether they get them from including a
particular header, or by having their own versions of those
instructions, it all looks the same in the binary.  It would be hard
work to claim the presence of those instructions constitutes a derived
work, any more than you could claim the instructions which set the stack
or registers up for a function call constitute a derived work.

	J

