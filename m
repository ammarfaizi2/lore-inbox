Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292974AbSBVTsx>; Fri, 22 Feb 2002 14:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292970AbSBVTsl>; Fri, 22 Feb 2002 14:48:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40712 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292973AbSBVTro>;
	Fri, 22 Feb 2002 14:47:44 -0500
Message-ID: <3C76A053.55A32E77@mandrakesoft.com>
Date: Fri, 22 Feb 2002 14:47:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020221213342.T1547-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> On Fri, 22 Feb 2002, Jeff Garzik wrote:
> > Only 1-2 SCSI drivers do PCI probing "the right way"...  IIRC aic7xxx is
> > one of them.
> 
> Could you, please, not mix PCI probing and SCSI probing.
> 
> Average user does not care about PCI probing. But it does care on booting
> the expected kernel image and mounting the expected partitions.
> It also doesn't care of code aesthetical issue even with free software
> since average user is not a kernel hacker.

Most SCSI drivers are not using the 2.4 PCI API, which has been
documented and stable for a while now.

This is need for transparented support for cardbus and hotplug PCI, not
some pie-in-the-sky code asthetic.  This will become further important
as 2.5.x transitions more and more to Mochel's driver model work, which
will among other things provide a sane power management model.

To tangent, IDE and SCSI hotplug issues are interesting, because a lot
of people forget or mix up the two types of hotplug, board (host)
hotplug and drive hotplug.

	Jeff


-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
