Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUBTBkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267688AbUBTBkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:40:11 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:18078 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S267686AbUBTBj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:39:57 -0500
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Tridge <tridge@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040220000054.GA5590@mail.shareable.org>
 <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
From: Junio C Hamano <junkio@cox.net>
Date: Thu, 19 Feb 2004 17:39:45 -0800
Message-ID: <7vznbeleam.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JL" == Jamie Lokier <jamie@shareable.org> writes:

JL> The other thing I like is that DN_IGNORE_SELF would be useful for
JL> other applications too.

While I agree in principle that DN_IGNORE_SELF would be quite an
effective and clean way to solve the Samba problem and also
applicable to other situations, I also imagine that the value of
DN_IGNORE_SELF would be greatly affected by how the "self" is
defined.  A server implementation may be multithreaded, and you
may or may not want to count all your threads in that server
process as self; another may be implemented as one master
process spawning multiple worker bee processes, in which case it
would be more convenient if all the processes in one process
group is counted as self.

