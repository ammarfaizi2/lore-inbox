Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSGSJm0>; Fri, 19 Jul 2002 05:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318504AbSGSJm0>; Fri, 19 Jul 2002 05:42:26 -0400
Received: from ns.suse.de ([213.95.15.193]:46094 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318503AbSGSJmZ>;
	Fri, 19 Jul 2002 05:42:25 -0400
Date: Fri, 19 Jul 2002 11:45:09 +0200
From: Andi Kleen <ak@suse.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Andi Kleen <ak@suse.de>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020719114509.B14588@wotan.suse.de>
References: <p73adopurv4.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0207181604140.16453-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181604140.16453-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 04:07:06PM -0700, James Simmons wrote:
> 
> > I also see similar problems on x86-64 in 2.5.25.  The kernel quickly crashes
> > when trying to return from opost_write() because something below has zeroed
> > out the stack (with serial console and vga console and early console enabled)
> > I have not tried it with 2.5.26 yet.
> 
> It is the result of registering the console device first for printk and
> then later registering the tty device. Eventually I like to be able to
> have VT_CONSOLE independent of CONFIG_VT so we could have a light weight
> printk. The goal is register tty device once we find a keyboard of some
> kind.


Could you explain to me how this causes a stack overwrite with the 
current kernel ? I would like to fix this ASAP because it is a showstopper
for me in 2.5 right now.

-Andi
