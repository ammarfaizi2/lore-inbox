Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTEKTHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTEKTHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:07:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34127 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261392AbTEKTHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:07:11 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <m1fznl74f9.fsf@frodo.biederman.org>
	<Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com>
	<20030511190023.GC9173@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 13:16:26 -0600
In-Reply-To: <20030511190023.GC9173@waste.org>
Message-ID: <m1of295m5x.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> There's a missing piece of behavior here that's probably fatal.
> Namely, the next time the CS descriptor is loaded, even with the same
> value, the high bits are lost. So, for example, if you're running BIOS
> out of ROM, decompressing it into the top of 20-bit address space,
> then long jumping to your uncompressed code, you don't want to find
> yourself back in ROM.
> 
> Perhaps there's a trick that can be played with loading the descriptor
> into CS and then clearing the descriptor table without flushing, but it
> sounds rather dubious..

If PE is really disabled that should bit should come for free.  And it
is why it is so hard to fake this behavior.

Eric
