Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUHDSqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUHDSqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHDSqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:46:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:60823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264936AbUHDSqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:46:16 -0400
Date: Wed, 4 Aug 2004 11:45:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Patrick McFarland <diablod3@gmail.com>
cc: arjanv@redhat.com, "J. Bruce Fields" <bfields@fieldses.org>,
       James Morris <jmorris@redhat.com>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: Linux 2.6.8-rc3
In-Reply-To: <d577e56904080411192f17e508@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0408041130530.24588@ppc970.osdl.org>
References: <4110FB0E.230CE613@users.sourceforge.net> 
 <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com> 
 <20040804161046.GD19282@fieldses.org> <1091636850.2792.19.camel@laptop.fenrus.com>
 <d577e56904080411192f17e508@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Aug 2004, Patrick McFarland wrote:
> 
> So will 2.6.8-rc4 be released with no optimized aes, or with a saner
> optimized aes?

We'll see just how quickly somebody steps up to the plate. I spent some
time taking the original Gladman source into gas format, and have a really
ugly (untested) direct conversion if somebody wants to work on it.

Side note: Jari Ruusu has himself been distributing the code he now 
objects to as part of his own linux kernel loop-aes patches. From the 
loop-aes README:

	Copyright 2001,2002,2003,2004 by Jari Ruusu.
	Redistribution of this file is permitted under the GNU Public License.

But the original x86 assembler code that is part of that loop-aes patch
was copyright Dr Brian Gladman, and was NOT originally under the GPL, so
it was Jari Ruusu who originally did something very suspect from a
copyright angle. Now he claims he never wanted to GPL it, but the fact is,
he's been distributing kernel patches with the code for a long time, and
claiming it is GPL'd.

So then David and James wanted to include it into the kernel as part of
the standard encryption layer, and I said no, since I felt the copyright
wasn't clear. So James asked Dr Gladman for permission to dual-license
under the GPL, and got it. So I was happy.

Now Jari Ruusu comes along and starts complaining about things. 

Jari: mitä helvetin järkeä tuossa on? Selitä.

		Linus
