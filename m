Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313422AbSDHJ5T>; Mon, 8 Apr 2002 05:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313607AbSDHJ5S>; Mon, 8 Apr 2002 05:57:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2576 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313422AbSDHJ5R>; Mon, 8 Apr 2002 05:57:17 -0400
Date: Mon, 8 Apr 2002 11:57:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408095717.GB27999@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Richard Gooch wrote:
> > 
> > But I *want* to write while the drive is spun down. And leave it spun
> > down until the system is RAM starved (or some threshold is reached).
> > 
> 
> Yes.  The desirable behaviour for laptops is to defer writes
> for a very long time, or until the user says "sync".
> 
> Mechanisms need to be put in place so that if there are pending
> writes and the disk happens to be spun up for a read, we take
> advantage of that spinup to push out the pending writes at
> the same time.
> 
> This behaviour should be all be enabled by a special "laptop mode"
> switch.
> 
> There's nothing particularly hard in all this...  I'll do a 2.5
> version at some stage.

Well, noflushd already seems to work pretty well ;-). But I see kernel
support may be required for SCSI.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
