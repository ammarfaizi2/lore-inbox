Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWGIRco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWGIRco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWGIRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:32:44 -0400
Received: from xenotime.net ([66.160.160.81]:34471 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964923AbWGIRcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:32:43 -0400
Date: Sun, 9 Jul 2006 10:35:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: adaplas@gmail.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Opinions on removing /proc/tty?
Message-Id: <20060709103529.bf8a46a4.rdunlap@xenotime.net>
In-Reply-To: <9e4733910607090645l236f17f1sb9778f0fc6c6ca01@mail.gmail.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
	<20060707223043.31488bca.rdunlap@xenotime.net>
	<9e4733910607072256q65188526uc5cb706ec3ecbaee@mail.gmail.com>
	<20060708220414.c8f1476e.rdunlap@xenotime.net>
	<9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com>
	<44B0D55D.2010400@gmail.com>
	<9e4733910607090645l236f17f1sb9778f0fc6c6ca01@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 09:45:06 -0400 Jon Smirl wrote:

> On 7/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Jon Smirl wrote:
> > > On 7/9/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > >> On Sat, 8 Jul 2006 01:56:02 -0400 Jon Smirl wrote:
> > >>
> > >> > On 7/8/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > >> > > I don't know how well this is an answer to your question,
> > >> > > but I would like to be able to find a list of registered "consoles,"
> > >> > > whether they be serial, usbserial, netconsole, lp, or whatever.
> > >> > > /proc/tty/drivers does that partially.
> > >> >
> > >> > Console is an overloaded word. Do you want to know where it is legal
> > >> > to send system log output to, or do you want to know where you can log
> > >> > in from? There was a thread earlier that talked a little about
> > >> > controlling this.
> > >>
> > >> I have a working definition:
> > >> I want to see a list of drivers that have called register_console().
> > >>
> > >> > > I have a patch that also does it in /proc/consoles:
> > >> > >   http://www.xenotime.net/linux/patches/consoles-list.patch
> > >> > > Is somewhere in /sys the right place to find a list of all consoles?
> > >> >
> > >> > /sys is the right place for this info but a class does not exist for
> > >> it yet.
> > >>
> > >> I want a list of registered consoles.  How would I express that in /sys ?
> > >
> > > You could make the list appear as an attribute in
> > > /sys/class/tty/console. You will need to all a little sysfs code after
> > > the console tty device is created.
> > >
> >
> > That would violate the one file, one value rule and GregKH will drop
> > it like a hot potato.
> >
> > A better solution is to have /sys/class/console.
> 
> The one value rule is for things that can be changed. For, example, I
> see no problem with using the graphics/modes attribute to see a list
> of legal modes, and then using graphics/mode to set or view the
> currently active mode. Why can't we have a read-only attribute that
> displays the list of available consoles?

We should be able to do that somewhere/somehow, but /sys does
not allow for it in one file, like Tony said.

---
~Randy
