Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265968AbSKFTgW>; Wed, 6 Nov 2002 14:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265954AbSKFTgW>; Wed, 6 Nov 2002 14:36:22 -0500
Received: from pirx.hexapodia.org ([208.42.114.113]:10774 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S265968AbSKFTgV>; Wed, 6 Nov 2002 14:36:21 -0500
Date: Wed, 6 Nov 2002 13:42:58 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Thomas Schenk <tschenk@origin.ea.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Need assistance in determining memory usage
Message-ID: <20021106134258.A12322@hexapodia.org>
References: <1036433472.2884.42.camel@shire> <1036436466.1106.105.camel@irongate.swansea.linux.org.uk> <1036437769.2902.76.camel@shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1036437769.2902.76.camel@shire>; from tschenk@origin.ea.com on Mon, Nov 04, 2002 at 01:22:44PM -0600
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:22:44PM -0600, Thomas Schenk wrote:
> On Mon, 2002-11-04 at 13:01, Alan Cox wrote:
> > On Mon, 2002-11-04 at 18:11, Thomas Schenk wrote:
> > > was adequate, I wouldn't be asking here and every reference I could find
> > > indicates that this is not a trivial problem.  There were also
> > > indications I found while searching that these tools do not always
> > > report memory numbers accurately.  If there is a way to determine this
> > > information using /proc, this would be ideal, since I could then
> > > conceivably create a script or simple program that could determine the
> > > answer given the process ID, which is what the developers here really
> > > want.
> > 
> > Neither the question nor the answer are trivial. What are you trying to
> > do with the data may be the most relevant question
> 
> This situation is this:
> 
> We are building an online game system.  On some of the systems, there
> are simulator processes running that each service a player.  There may
> be up to 200 or more of these processes running at any given time and
> each uses a fairly large amount of memory (as reported by ps).  Part of
> this is due to the fact that the processes have not been optimized to
> make the most efficient use of memory.  When the simulator processes
> start swapping, then the systems are becoming unstable, performance goes
> all to hell and sometimes the systems totally hang.  It would be useful
> for us to be able to monitor as closely as possible the amount of memory
> each processes is using and especially to be notified when these
> processes start using significant amounts of swap, so that we can be
> prepared to react before the situation gets out of hand.

I do not believe that the kernel exports the information "what processes
are using swap?".  You can answer some of your questions by using my
pmap program; it's in at least some recent procps packages, or download
the source:
http://web.hexapodia.org/~adi/pmap.c

-andy
