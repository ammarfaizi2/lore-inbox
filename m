Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSJWQy6>; Wed, 23 Oct 2002 12:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSJWQy6>; Wed, 23 Oct 2002 12:54:58 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:59870 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265085AbSJWQyw>;
	Wed, 23 Oct 2002 12:54:52 -0400
Date: Wed, 23 Oct 2002 19:01:02 +0200
From: bert hubert <ahu@ds9a.nl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
Message-ID: <20021023170102.GA5302@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	"David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl> <1035379308.5950.3.camel@rth.ninka.net> <200210231542.48673.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210231542.48673.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 03:42:48PM +0200, Roy Sigurd Karlsbakk wrote:
> > The e1000 can very well do hardware checksumming on transmit.
> >
> > The missing piece of the puzzle is that his application is not
> > using sendfile(), without which no transmit checksum offload
> > can take place.
> 
> As far as I've understood, sendfile() won't do much good with large files. Is 
> this right?

I still refuse to believe that a 1.8GHz Pentium4 can only checksum
250megabits/second. MD Raid5 does better and they probably don't use a
checksum as braindead as that used by TCP.

If the checksumming is not the problem, the copying is, which would be a
weakness of your hardware. The function profiled does both the copying and
the checksumming.

But 250megabits/second also seems low.

Dave? 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
