Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSK1CWy>; Wed, 27 Nov 2002 21:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSK1CWy>; Wed, 27 Nov 2002 21:22:54 -0500
Received: from bitmover.com ([192.132.92.2]:64141 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265096AbSK1CWx>;
	Wed, 27 Nov 2002 21:22:53 -0500
Date: Wed, 27 Nov 2002 18:30:09 -0800
From: Larry McVoy <lm@bitmover.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, "Richard B. Tilley (Brad)" <rtilley@vt.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Verifying Kernel source
Message-ID: <20021127183009.G9443@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Larry McVoy <lm@bitmover.com>,
	"Richard B. Tilley  (Brad)" <rtilley@vt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20021127092818.Q24374@work.bitmover.com> <Pine.GSO.4.21.0211272326350.5044-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211272326350.5044-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Nov 27, 2002 at 11:29:27PM +0100
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 11:29:27PM +0100, Geert Uytterhoeven wrote:
> On Wed, 27 Nov 2002, Larry McVoy wrote:
> > > What is the proper way to verify the kernel source before compiling?
> > > There have been too many trojans of late in open source and free
> > > software and I, for one, am getting paranoid.
> > 
> > If it's in BK you can be pretty sure that it is what was checked in,
> > BK checksums every diff in every file.  It's not at all impossible
> > to fool the checksum but it is very unlikely that you can cause 
> > semantic differences in the form of a trojan horse and still fool 
> > the checksums.
> 
> It depends on the checksum algorithm. If it's not `strong' (e.g. simple crc32),
> I can easily add some specially tailored unused data to the code of which the
> sole purpose is to make the checksum still match.

Oh, sure, you could, but you'd have to go edit the SCCS files by hand,
which is certainly doable, but it raises the bar past most of the
script kiddies who do this sort of thing.

Ted T'so and I have discussed the idea of adding strong signatures to BK
several times.  It would be easy to do and it would completely defeat any
attempt to stick a trojan into an existing changeset.  So we could and will
if it ever becomes a real problem.

On the other hand, bkbits.net is updated by Linus directly and we've never
had a breakin there (knock on wood) so you are relatively safe if you are
tracking the tree from there.  Now that I've said that some slashdot
kiddie with more balls than brains will happily beat their brains out
to break in, but we'll fix it if it happens.

The bottom line is that, so far, the BK tree is safe.  I'll personally
commit to providing strong crypto based signatures for changesets within
1 week of the date when someone sticks a trojan in a BK tree.  It's not
that hard, but it's also a problem that doesn't exist (yet).  And we have
lots of things to do, just ask any BK user...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
