Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSCEVme>; Tue, 5 Mar 2002 16:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291074AbSCEVmO>; Tue, 5 Mar 2002 16:42:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289348AbSCEVmN>;
	Tue, 5 Mar 2002 16:42:13 -0500
Message-ID: <3C853BC9.EC553363@mandrakesoft.com>
Date: Tue, 05 Mar 2002 16:42:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Arjan van de Ven <arjanv@redhat.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au> <3C84A34E.6060708@evision-ventures.com> <3C84AE16.A7F1ECCA@redhat.com> <20020305221933.A405@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Tue, Mar 05, 2002 at 11:37:58AM +0000, Arjan van de Ven wrote:
> > Martin Dalecki wrote:
> >
> > > - Disable configuration of the task file stuff. It is going to go away
> > >    and will be replaced by a truly abstract interface based on
> > >    functionality and *not* direct mess-up of hardware.
> >
> > Can we also expect a patch to remove the scb's from the scsi midlayer
> > from you ?
> > I mean, if a standard specifies a nice *common* command packet format
> > I'd expect the midlayer
> > to create such packets. Taskfile is exactly that... why removing it ?
> 
> Note that taskfiles are not being removed from IDE. Just direct (and
> parsed and filtered) interface to userspace. Does the scsi midlayer
> export the SCBs directly to userspace?

It should.

I think it's a mistake to remove the taskfile interface.

It provides a way for people to directly validate the lowest level IDE
interface, without interference from upper layers.  It also provides
access to userspace for important features that -should not- be in the
kernel, like SMART monitoring and security features.

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
