Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265087AbSJWQIA>; Wed, 23 Oct 2002 12:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbSJWQIA>; Wed, 23 Oct 2002 12:08:00 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:45495 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265087AbSJWQHy>; Wed, 23 Oct 2002 12:07:54 -0400
Date: Wed, 23 Oct 2002 11:13:58 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Armin Schindler <mac@melware.de>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: module_init in interrupt context ?
In-Reply-To: <Pine.LNX.4.31.0210230640250.6294-100000@phoenix.one.melware.de>
Message-ID: <Pine.LNX.4.44.0210231111480.2739-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Armin Schindler wrote:

> With kernel 2.4.19 I noticed that calls from module_init()
> may be done in interrupt context. I didn't have a problem here
> before 2.4.17.

Well, I am positive that this is not so.

> E.g. in module_init() I use pci_module_init() for my driver
> (I don't have HOTPLUG enabled), the when the .probe function is called
> and the card is detected I create a proc entry for this new
> found device, but most of the time create_proc_entry causes
> BUG(), because it is called from interrupt context.

I think you should provide the backtrace and the code in questions. 
Obviously, something is wrong, but it's virtually impossible that 
module_init() runs from irq context, so it has to be something else.

--Kai

