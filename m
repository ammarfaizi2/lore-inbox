Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314196AbSDQXYi>; Wed, 17 Apr 2002 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314199AbSDQXYh>; Wed, 17 Apr 2002 19:24:37 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:31229
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314196AbSDQXYg>; Wed, 17 Apr 2002 19:24:36 -0400
Date: Wed, 17 Apr 2002 16:26:34 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kent Borg <kentborg@borg.org>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nick@snowman.net,
        Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        Mike Dresser <mdresser_l@windsormachine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020417232634.GC574@matchmail.com>
Mail-Followup-To: Kent Borg <kentborg@borg.org>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, nick@snowman.net,
	Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
	Mike Dresser <mdresser_l@windsormachine.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204171108480.3300-100000@ns> <E16xrfQ-0002VF-00@the-village.bc.nu> <20020417102722.B26720@vger.timpanogas.org> <20020417134716.D10041@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 01:47:16PM -0400, Kent Borg wrote:
> 
> On Wed, Apr 17, 2002 at 10:27:22AM -0700, Jeff V. Merkey wrote:
> > From my analysis with 3Ware at 32 drive configurations, you really
> > need to power the drives from a separate power supply is you have 
> > more than 16 devices.  They really suck the power during initial 
> > spinup.
> 
> It seems an obvious help would be to have the option of spinning up
> the drives one at a time at 2-3 second intervals.  I know a fast drive
> doesn't get up to speed in 3 seconds, but the nastiest draw is going
> to be over by then.
> 
> A machine with 32 drives is pretty serious stuff and probably isn't
> booting in a few seconds anyway--another 60-some seconds might be a
> desirable option.
> 
> Does this exist anywhere?  Would it have to be a BIOS feature?

I doubt it.

All of the IDE drives I have used spin up when power is applied.  Most of
the scsi (except for some really old ones) have a jumper that tells the
drive to wait until it receives a message from the scsi controller to spin up.

I'd imagine that IDE would need some protocol spec changes before this could
be supported (at least a "spin the drive up" message...).

Mike
