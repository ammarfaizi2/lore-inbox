Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTEKTD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTEKTD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:03:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33359 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261275AbTEKTDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:03:25 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
	<200305111137.29743.josh@stack.nl>
	<20030511140144.GA5602@mail.jlokier.co.uk>
	<Pine.LNX.4.50.0305111033590.7563-100000@blue1.dev.mcafeelabs.com>
	<m1fznl74f9.fsf@frodo.biederman.org>
	<Pine.LNX.4.50.0305111119590.7563-100000@blue1.dev.mcafeelabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 13:12:51 -0600
In-Reply-To: <Pine.LNX.4.50.0305111119590.7563-100000@blue1.dev.mcafeelabs.com>
Message-ID: <m1smrl5mbw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On Sun, 11 May 2003, Eric W. Biederman wrote:
> 
> > The remapping is quite common but it usually happens that after bootup:
> > 0xf0000-0xfffff is shadowed RAM.  While 0xffff0000-0xffffffff still points
> > to the rom chip.
> >
> > Now if someone could tell me how to do a jump to 0xffff0000:0xfff0 in real
> > mode I would find that very interesting.
> 
> Have you ever heard about unreal mode ? But I do not think that a reset
> has to start over there. I do not think that exist hw/sw that expect that
> reset address to be 0xfffffff0 instead of 0x000ffff0, since they map the
> same content.

There is some software at least that knows the difference.  I have seen short
jumps in a couple of BIOS's.  But a reset is very different from a
reboot.  As memory must be reinitialized etc.  So I think going to
0xffff0000:0xfff0 would be a very bad idea if the intent is to get a
reliable reboot.


Eric
