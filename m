Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFBP5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFBP5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFBP5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:57:45 -0400
Received: from av2.karneval.cz ([81.27.192.108]:32030 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S261178AbVFBP4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:56:19 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: "Jose Pascual" <josepascual@almudi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LinCAN 0.3-rc1 for ARM
Date: Thu, 2 Jun 2005 17:58:36 +0200
User-Agent: KMail/1.8
References: <003001c5676b$4b97ac40$2219a8c0@dominio1.ingalmudi.com>
In-Reply-To: <003001c5676b$4b97ac40$2219a8c0@dominio1.ingalmudi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021758.36521.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 June 2005 14:04, you wrote:
> Hi Pavel,
>
> How about to add your LinCAN into kernel tree (mainstream could be very
> difficult) f.e. in
> driver/char/can directory?
>
> It'd be necessary only to patch Kconfig and Makefile and standalone
> version, I think , what do you?
> It can allow to compile LinCAN inside kernel not as module.

Hello Jose and all others,

I am sending this reply even to LKML, because Linux CAN
specific lists are fragmented and sometimes dead same way as many
Linux CAN related projects. If somebody is convinced, that he knows
the right Linux CAN bus related central place, redirect me to it, please.

The LinCAN integration would be interresting and great, but it would
require big-big-big amount of work and common consensus

- there is too many Linux CAN related drivers and works.
  Many of them are dead branches of two or three initial projects
  which has disappeared over time. There is more fully functional
  single chip or single vendor specific CAN drivers now.

- I have tried to lay fast infrastructure for CAN messages
  handling through generalized FIFOs concept, but there
  could be objections to my concept

- the boards support has been based on Arnaud's Westenberg CAN project
  so knowledge accumulated about different cards in this project
  and even original Claus Schroeter LDDK projects (both dead and sites
  not updated for many years) has been preserved in the LinCAN driver

- LinCAN is one of very little Linux CAN drivers, which are prepared
  to support many different hardware kinds even in one build,
  it means some code and time overhead. It supports SJA1000
  i82527 chips and some intelligent cards. It is used on even
  on ARM and PowerPC base industrial boards with more different
  cards.

- it has been adapted by some companies for their cards as well.
  But not all of them provided feedback and are best Linux
  community citizens. This is shame for them, because they would
  have problems to keep their changes usebale with evolving
  LinCAN core sources and it hurts us, because we lose
  bigger picture of our code usage and adaptations helping different
  hardware and applications. I hate idea of diverging and hidden branches.

- on the other hand LinCAN has advantage, that it is not bound
  by any commercial subject a has been accepted by more companies

- LinCAN is used at some universities and it is adapted for their
  projects special needs

- LinCAN supports 2.2.x, 2.4.x and 2.6.x kernels. At least 2.4.x
  and 2.6.x is required for now. This is fundamental problem for inclusion
  into 2.6.x kernel, because we can not switch to 2.6.x driver model
  if 2.4.x has to be supported. I fully understand that it would be required
  by 2.6.x kernel maintainers, but we (at CTU) have not enough financial
  and personal resources to maintain two branches diverging in the time 
  
- LinCAN supports RT-Linux, but RTAI is missing, again, it is not too
  difficult problem, we have some experience with RTAI, but our power
  is limited. Even nobody from RTAI core community offered significant
  interrest or help in this case.

- there is very long list of ideas and features which should be implemented
  or at least evaluated.
  Traffic statistics, possibility to use more communication objects
  as hardware FIFO in some chips. Fast distinct ID per chip filterring etc.

This all means, that there is probably zero chance for inclusion in
the mid range future. Our original goal of CTU part in the OCERA project
has been to work on CANopen and ETERNET RTPS protocols. The work
on the driver has been result of our frustration how many incompatible
and insufficient half life Linux CAN drivers exists. We have tried to start
from widely accepted base to not start new totally incompatible branch.
Others has to evaluate value of our work.

The conclusion is:
we would like to hear and collect others opinion. We would be happy for
provided help and new boards/hardware support contributions.
If there is consensus that LinCAN is useful for more users and accepted
by more developers, we would try to find funding for university project
to boost development. I think, that right time for re-evaluation
of LinCAN inclusion into Linux kernel would be when 2.4.x Linux kernel
is superseded by 2.6.x in near absolute majority of Linux embedded project.
I do not expect that such time comes before and of this year.
I have fear that even at that time CAN users base would be considered
as minority and inclusion of the CAN driver into mainline would be
considered as kernel bloating by most of others.

About CAN bus and LinCAN

The CAN bus is used in many industrial and automotive applications.
It can be found in each modern vehicle, many robots, servo-drivers etc.
Many embedded microcontrollers have on the chip integrated CAN controller.
  http://www.can-cia.org/

FreshMeat LinCAN entry
  http://freshmeat.net/projects/lincan

OCERA (http://www.ocera.org/) - Communication components
  http://www.ocera.org/download/components/WP7/index.html

Some short quick start info on my page
  http://cmp.felk.cvut.cz/~pisa/#can

Latest PDF doc with internals, history, other CAN drivers evaluation
  http://cmp.felk.cvut.cz/~pisa/can/doc/lincandoc-0.2.pdf

One of our department projects utilizing LinCAN and Presentation
  http://dce.felk.cvut.cz/retobot/
  http://www.linuxexpo.cz/prezentace2005/OCERA_LinuxExpo_2005.pdf

Best wishes

                Pavel Pisa
