Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTEBSNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTEBSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:13:12 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263048AbTEBSNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:13:12 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
To: mingo@redhat.com (Ingo Molnar)
Date: Fri, 2 May 2003 19:29:38 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven),
       davidel@xmailserver.org (Davide Libenzi),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com> from "Ingo Molnar" at May 02, 2003 01:32:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Ingo, do you want protection against shell code injection ? Have the
> > > kernel to assign random stack addresses to processes and they won't be
> > > able to guess the stack pointer to place the jump. I use a very simple
> > > trick in my code :
> > 
> > stack randomisation is already present in the kernel, in the form of
> > cacheline coloring for HT cpus...
> 
> we could make it even more prominent than just coloring, to introduce the
> kind of variability that Davide's approach introduces. It has to be a
> separate patch obviously. This would further reduce the chance that a
> remote attack that has to guess the stack would succeed on a random box.

Slightly off-topic, but does anybody know whether IA64 or x86-64 allow
you to make the stack non-executable in the same way you can on SPARC?

John.
