Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbREQJz1>; Thu, 17 May 2001 05:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbREQJzR>; Thu, 17 May 2001 05:55:17 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:58375 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S261386AbREQJy5>; Thu, 17 May 2001 05:54:57 -0400
Date: Thu, 17 May 2001 05:35:49 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: esr@thyrsus.com, Pavel Machek <pavel@suse.cz>,
        Jes Sorensen <jes@sunsite.dk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010517053549.A17562@munchkin.spectacle-pond.org>
In-Reply-To: <20010517032636.A1109@thyrsus.com> <28870.990085661@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <28870.990085661@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, May 17, 2001 at 05:47:41PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 05:47:41PM +1000, Keith Owens wrote:
> On Thu, 17 May 2001 03:26:36 -0400, 
> "Eric S. Raymond" <esr@thyrsus.com> wrote:
> >Pavel Machek <pavel@suse.cz>:
> >> And If I want scsi-on-atapi emulation but not vme147_scsi?
> >
> >Help me understand this case, please.  What is scsi-on-atapi?
> >Is SCSI on when you enable it?  And is it a realistic case for an SBC?
> 
> SCSI emulation over IDE, CONFIG_BLK_DEV_IDESCSI.  You have the SCSI mid
> layer code but no SCSI hardware drivers.  It is a realistic case for an
> embedded CD-RW appliance.

Or alternatively, you want to enable SCSI code, with no hardware driver,
because you are going to build pcmcia, which builds the scsi drivers only if
CONFIG_SCSI is defined, and the user might put in an Adaptec 1460B or 1480 scsi
card into your pcmcia slot.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
