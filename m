Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281613AbRKMMJT>; Tue, 13 Nov 2001 07:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281617AbRKMMJJ>; Tue, 13 Nov 2001 07:09:09 -0500
Received: from unthought.net ([212.97.129.24]:6587 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281613AbRKMMJC>;
	Tue, 13 Nov 2001 07:09:02 -0500
Date: Tue, 13 Nov 2001 13:09:01 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Pascal Schmidt <pleasure.and.pain@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011113130901.F30421@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Pascal Schmidt <pleasure.and.pain@web.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011111204305.A16792@unthought.net> <Pine.LNX.4.33.0111121441030.1184-100000@neptune.sol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0111121441030.1184-100000@neptune.sol.net>; from pleasure.and.pain@web.de on Mon, Nov 12, 2001 at 02:43:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 02:43:41PM +0100, Pascal Schmidt wrote:
> On Sun, 11 Nov 2001, Jakob Østergaard wrote:
> 
> > Now, my program needs to deal with the data, perform operations on it,
> > so naturally I need to know what kind of data I'm dealing with.  Most likely,
> > my software will *expect* some certain type, but if I have no way of verifying
> > that my assumption is correct, I will lose sooner or later...
> 
> Why not read everything into a 1024-bit signed variable? Will work for 
> every numeric value in /proc. It's a bit of a hassle to code, but it is 
> possible. You only need to know the type if you want to write a numerical 
> value to a file in /proc, and even then the driver behind that /proc entry 
> should do sanity checks.

So for 99.9% of all cases my program will do much much more work than is
actually needed.

I may still save the data in a database, or go over the network with it,
so I should implement 1024 bit signed integers in all of that code too ?

And what happens when we do crypto and 1024 bits is not enough ?

I think the "use rediculously large datatypes" solution is a poor one,
as it can never cover all cases in the future, and it will impose a large
overhead on existing and new applications.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
