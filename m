Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSDLIBE>; Fri, 12 Apr 2002 04:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313423AbSDLIBD>; Fri, 12 Apr 2002 04:01:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64322 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313421AbSDLIBC>; Fri, 12 Apr 2002 04:01:02 -0400
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using video memory as system memory
In-Reply-To: <Pine.LNX.4.44.0204091816380.13516-100000@winds.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Apr 2002 01:54:05 -0600
Message-ID: <m14rihl5cy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> writes:

> I have an old 586 that has low memory and no ability for further upgrades.
> I had an idea to use the framebuffer memory of a 32MB video card lying around
> the office as system memory and implemented the following patch:

There are significant speed differences between video card ram
and ram on a PCI card.  

Setup an mtd device and use the video card ram for swap.  It's
about 10 lines more code, is testable as a module, and is code that
is clean enough some variant of it might even get into the kernel.

Eric
