Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbSKZF5i>; Tue, 26 Nov 2002 00:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSKZF5i>; Tue, 26 Nov 2002 00:57:38 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:39183 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S266179AbSKZF5h>; Tue, 26 Nov 2002 00:57:37 -0500
Date: Tue, 26 Nov 2002 01:07:31 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Andi Kleen <ak@suse.de>
cc: Jeff Dike <jdike@karaya.com>, <linux-kernel@vger.kernel.org>
Subject: Re: uml-patch-2.5.49-1
In-Reply-To: <p73u1i4ub3g.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0211260105400.7540-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2002, Andi Kleen wrote:

> Jeff Dike <jdike@karaya.com> writes:
> > main points:
> > 	the kernel is in a separate process and address space from its processes
> > 	UML processes share a single host process
>
> Can you quickly describe why you didn't use one host process per uml
> process ?
>
> That would have avoided the need for a /proc/mm extension too I guess.

One reason I can think of is that it prevents 'stupid things' happening
under a copy of UML from killing the OS UML is running under... Eg. if a
process is running under UML because it's not trusted and then turns into
a forkbomb, you don't want that taking down the host OS.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


