Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSFFNYh>; Thu, 6 Jun 2002 09:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSFFNYg>; Thu, 6 Jun 2002 09:24:36 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:53002 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S316953AbSFFNYV>; Thu, 6 Jun 2002 09:24:21 -0400
Message-ID: <3CFF62A7.2AB5B0F1@compro.net>
Date: Thu, 06 Jun 2002 09:24:55 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Hudec <bulb@ucw.cz>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <3CFD19D1.5768FCF8@compro.net> <20020605194716.4290.qmail@web14906.mail.yahoo.com> <20020606085907.GA28704@artax.karlin.mff.cuni.cz> <3CFF2880.8D697F90@cfl.rr.com> <20020606112234.GA20035@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec wrote:
> 
> On Thu, Jun 06, 2002 at 05:16:48AM -0400, Mark Hounschell wrote:
> > That isn't the case.  There is no /etc/modules file on any Linux box I've
> > ever used. My network driver modules are loaded automatically by the kernel's
> > internal module loader "kmod" because the are set up correctly in /etc/modules.conf.
> >
> > "alias eth0 3c905"
> >
> > ALL device driver modules can be set up to load automatacally by "kmod".
> 
> That I didn't know. However, I have a computer with four network cards
> in it. Since they are numbered dynamicaly, loading modules in different
> order results in different numbering of devices. How do I assure that
> upon request for eg. eth2 the loaded module is assigned eth2?

The order in which they are labeled is the order the are found during the pci scan.
The lspci command should tell you which is which. Then place the correct entries in
/etc/modules.conf


alias eth0 3c905
alias eth1 blabla
alias eth2 blablaaaa
.
.


Regards
Mark
