Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284240AbRLTL3r>; Thu, 20 Dec 2001 06:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284242AbRLTL3h>; Thu, 20 Dec 2001 06:29:37 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:48829 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S284240AbRLTL32>; Thu, 20 Dec 2001 06:29:28 -0500
Date: Thu, 20 Dec 2001 12:29:27 +0100
From: bert hubert <ahu@ds9a.nl>
To: Julian Anastasov <ja@ssi.bg>
Cc: kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG/WANT TO FIX] Equal Cost Multipath Broken in 2.4.x
Message-ID: <20011220122927.A12949@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Julian Anastasov <ja@ssi.bg>,
	kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011220112728.A11112@outpost.ds9a.nl> <Pine.LNX.4.33.0112201316210.4670-100000@l>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112201316210.4670-100000@l>; from ja@ssi.bg on Thu, Dec 20, 2001 at 01:21:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:21:30PM +0200, Julian Anastasov wrote:

> > If anybody can point me in the direction of this problem, it must be known
> > as it has been there for a *long* time, it would be appreciated. I'll try to
> 
> 	Yes, I remember people to report for this problem for long
> time but I was not able to reproduce it. May be it could be fixed
> with the following change (only compiled):

Your patch does not appear to relate to iproute-20010824. I think I've found
the problem, however. I think there has been an API change between 2.2 and
2.4. 'ip' compiled under 2.2 will not properly configure ECMP on 2.4!

If I recompile tc under 2.4, the problem disappears.

Maybe ip should warn against this? Should be easy to do.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
