Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273789AbRIXEfG>; Mon, 24 Sep 2001 00:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273790AbRIXEe4>; Mon, 24 Sep 2001 00:34:56 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:24251 "HELO bg77.anu.edu.au")
	by vger.kernel.org with SMTP id <S273789AbRIXEek>;
	Mon, 24 Sep 2001 00:34:40 -0400
Date: Mon, 24 Sep 2001 14:35:01 +1000
From: Simon Fowler <simon@bg77.anu.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010924143501.A19387@bg77.anu.edu.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>, <9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com> <3BAEAC52.677C064C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAEAC52.677C064C@zip.com.au>; from akpm@zip.com.au on Sun, Sep 23, 2001 at 08:45:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 08:45:22PM -0700, Andrew Morton wrote:
> Aaron Lehmann wrote:
> > 
> > On Mon, Sep 24, 2001 at 02:06:05AM +0000, Linus Torvalds wrote:
> > > We'll merge ext3 soon enough.. As RH seems to start using it more and
> > > more, there's more reason to merge it into the standard kernel too.
> > >
> > > So don't worry. It will happen.

Speaking of ext3 and 2.4.10, do you have an idea when you could
get an updated ext3 patch for 2.4.10? I tried applying the latest
0.9.9 patch to 2.4.10-pre12, fixing the rejections by hand, but
the result was an oops when fsck.ext3 ran on boot.

The biggest problem was with the changes in mm/vmscan.c - I added
try_to_release_page(), and replaced the only call to
try_to_free_buffers() that I found (as the patch did). All the
other rejections were one liners.

I've seen reports of ext3 working with the vmscan.c hunk ignored
- is this a reasonable approach?

Thanks for any assistance,
Simon Fowler

--
PGP public key Id 0x144A991C, or ftp://bg77.anu.edu.au/pub/himi/himi.asc
(crappy) Homepage: http://bg77.anu.edu.au
doe #237 (see http://www.lemuria.org/DeCSS) 
My DeCSS mirror: ftp://bg77.anu.edu.au/pub/mirrors/css/ 
