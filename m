Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262026AbREQQgn>; Thu, 17 May 2001 12:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbREQQgd>; Thu, 17 May 2001 12:36:33 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:33807
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S262026AbREQQgU>; Thu, 17 May 2001 12:36:20 -0400
Date: Thu, 17 May 2001 09:34:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: Keith Owens <kaos@ocs.com.au>, esr@thyrsus.com,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010517093411.A12740@opus.bloom.county>
In-Reply-To: <20010517032636.A1109@thyrsus.com> <28870.990085661@kao2.melbourne.sgi.com> <20010517053549.A17562@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010517053549.A17562@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Thu, May 17, 2001 at 05:35:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 05:35:49AM -0400, Michael Meissner wrote:
> On Thu, May 17, 2001 at 05:47:41PM +1000, Keith Owens wrote:
> > On Thu, 17 May 2001 03:26:36 -0400, 
> > "Eric S. Raymond" <esr@thyrsus.com> wrote:
> > >Pavel Machek <pavel@suse.cz>:
> > >> And If I want scsi-on-atapi emulation but not vme147_scsi?
> > >
> > >Help me understand this case, please.  What is scsi-on-atapi?
> > >Is SCSI on when you enable it?  And is it a realistic case for an SBC?
> > 
> > SCSI emulation over IDE, CONFIG_BLK_DEV_IDESCSI.  You have the SCSI mid
> > layer code but no SCSI hardware drivers.  It is a realistic case for an
> > embedded CD-RW appliance.
> 
> Or alternatively, you want to enable SCSI code, with no hardware driver,
> because you are going to build pcmcia, which builds the scsi drivers only if
> CONFIG_SCSI is defined, and the user might put in an Adaptec 1460B or 1480 scsi
> card into your pcmcia slot.

Both of these 'problems' assume that you can have IDE or PCMCIA on these
particular boxes.  Does anyone know if that's actually true?

What eric is trying to do, can work, if done very carefully, and in very 
limited cases as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
