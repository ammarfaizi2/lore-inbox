Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313702AbSDHQsJ>; Mon, 8 Apr 2002 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313704AbSDHQsI>; Mon, 8 Apr 2002 12:48:08 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:5111 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S313702AbSDHQsG>; Mon, 8 Apr 2002 12:48:06 -0400
Date: Mon, 8 Apr 2002 12:48:03 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408124803.A14935@redhat.com>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 05:43:33PM +0100, Jamie Lokier wrote:
> Pavel Machek wrote:
> > Well, noflushd already seems to work pretty well ;-). But I see kernel
> > support may be required for SCSI.
> 
> I've had no luck at all with noflushd on my Toshiba Satellite 4070CDT.
> It would spin down every few minutes, and then spin up _immediately_,
> every time.  I have no idea why.

Were you using the console?  Any activity on ttys causes device inode 
atime/mtime updates which trigger disk spin ups.  The easiest way to 
work around this is to run X while using devpts for the ptys.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
