Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUJQVZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUJQVZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQVZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 17:25:37 -0400
Received: from rage.4t2.com ([217.20.115.48]:58555 "EHLO rage.4t2.com")
	by vger.kernel.org with ESMTP id S267839AbUJQVZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 17:25:32 -0400
Date: Sun, 17 Oct 2004 23:25:11 +0200
From: Thomas Weber <l_linux-kernel@mail2news.4t2.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Weber <l_linux-kernel@mail2news.4t2.com>,
       Tonnerre <tonnerre@thundrix.ch>, Josh Boyer <jdub@us.ibm.com>,
       root@chaos.analogic.com, gene.heskett@verizon.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041017212511.GA7675@4t2.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com> <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net> <1097857049.29988.29.camel@weaponx.rchland.ibm.com> <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com> <1097862366.29988.51.camel@weaponx.rchland.ibm.com> <20041015201147.GA23355@thundrix.ch> <20041017201832.GA28859@4t2.com> <Pine.GSO.4.61.0410172249400.27743@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410172249400.27743@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6+20040722i
X-4t2Systems-MailScanner: Found to be clean
X-4t2Systems-MailScanner-From: l_linux-kernel@mail2news.4t2.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 10:52:38PM +0200, Geert Uytterhoeven wrote:
> On Sun, 17 Oct 2004, Thomas Weber wrote:
> > On Fri, Oct 15, 2004 at 10:11:47PM +0200, Tonnerre wrote:
> > > What trusted computing revealed is that there is at least amongst some
> > > companies  a desire  to be  able to  dictate what's  going on  on your
> > > computer. Think Disney here.
> > 
> > 
> > > 			    Tonnerre
> > > 
> > > PS. I did a module signing patch  some years ago. I did a framework. I
> > >     did tests. I got scared of its power. All I say is, take care.
> > 
> > Think about companies deploing binary only drivers for their hardware.
> > I guess they'd be happy to have a 'feature' like this in the kernel.
> > We might end up with hardware companies deploying binary only signed 
> > modules for the major distributions (with which they have deals).
> > We might end up with weird patches from those companies to get their key
> > into the kernel source in order to be able to load their signed module.
> > 
> > Once a module itself requires this feature in the kernel you don't have
> > the choice of saying 'No' to this option of compile time and you can't
> > simply revert this patch anymore as others have suggested.
> > 
> > This patch would give power to those who make binary distributions and
> > (binary only) modules not to the admin who runs the system.
> > Only allowing modules to be loaded from a secured area (read only
> > device, signed 'container' of modules...) and leaving it to the
> > admin which modules he puts into this area would address all the reasons
> > for this patch without taking power away from the owner of the system.
> 
> Solution: the module loader refuses to load signed modules that are not GPLed?
> I.e. a combination of MODULE_LICENSE() and signed modules.
> 
> Opens up interesting legal actions if the signature owner signs modules that
> claim to be GPL, but aren't. Digital signatures are starting to become valid
> signatures in many countries...

What if distributions ship with this check removed (maybe distributions that 
have deals with such companies)? 
What if a binary module comes with a kernel source patch that removes this 
check?
Who's gonna pay the lawyers?

  Tom
