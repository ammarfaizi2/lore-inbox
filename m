Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313535AbSDJTAL>; Wed, 10 Apr 2002 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313362AbSDJTAL>; Wed, 10 Apr 2002 15:00:11 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:32984 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313535AbSDJTAK>;
	Wed, 10 Apr 2002 15:00:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15540.35767.394315.176611@napali.hpl.hp.com>
Date: Wed, 10 Apr 2002 12:00:07 -0700
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic access to firmware environment variables
In-Reply-To: <20020410184231.GC8136@lug-owl.de>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 10 Apr 2002 20:42:31 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> said:

  Jan-Benedict> Hi!  I've developed a driver to access environment
  Jan-Benedict> variables on Alpha computers from userspace through
  Jan-Benedict> procfs some time ago. These days, I updated the
  Jan-Benedict> driver. While doing this, I also looked at other
  Jan-Benedict> architectures; some of them also do have some kind of
  Jan-Benedict> environment variables in firmware:

  Jan-Benedict> 	Alphas - SRM firmware SGI Workstations - ARCS
  Jan-Benedict> firmware MIPS/ITE-Boards - PMON m68k/MAC - ?? (info is
  Jan-Benedict> placed into a "bootinfo" struct) IA64 - (_seems_ to
  Jan-Benedict> know about environment...)

  Jan-Benedict> They all access environment variables either by name,
  Jan-Benedict> or by an internally handles number. For Alpha, I've
  Jan-Benedict> (now) implemented both, access by name (if variable
  Jan-Benedict> name is known/described) and access by generic number.

  Jan-Benedict> I think it would be useful to have something like this
  Jan-Benedict> for other architectures as well. So I'm currently
  Jan-Benedict> thinking about implementing a base driver (like
  Jan-Benedict> parport does) and additional modules to implement
  Jan-Benedict> machine/architecture specific access methode (like
  Jan-Benedict> parport_pc).

  Jan-Benedict> It's easy to code, so what do you think of this?

On EFI platforms, there is /proc/efi/vars.  The module was written by
Matt Domsch <Matt_Domsch@Dell.com>.  EFI is used on ia64 and x86
servers.  Note that EFI variables can contain arbitrary binary data,
not just text strings.

	--david
