Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284244AbRLAUwb>; Sat, 1 Dec 2001 15:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284249AbRLAUwW>; Sat, 1 Dec 2001 15:52:22 -0500
Received: from gate.mesa.nl ([194.151.5.70]:784 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S284244AbRLAUwH>;
	Sat, 1 Dec 2001 15:52:07 -0500
Date: Sat, 1 Dec 2001 21:51:46 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Andries.Brouwer@cwi.nl
Cc: adilger@turbolabs.com, aia21@cus.cam.ac.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Message-ID: <20011201215146.A12511@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <UTC200112011147.LAA114060.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200112011147.LAA114060.aeb@cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Dec 01, 2001 at 11:47:34AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 11:47:34AM +0000, Andries.Brouwer@cwi.nl wrote:
>     From: Andreas Dilger <adilger@turbolabs.com>
> 
>     > Please consider below patch which adds the starting sector and number of
>     > sectors to /proc/partitions.
> 
>     Please do not accept as-is.  This breaks the format of /proc/partitions
>     terribly, and all of the code that looks at it (fsck, mount, etc).
> 
> Indeed.
> 
>     Rather add the start_sect and nr_sects parameters _after_ the name
>     parameter, and it will be "mostly" ok.
> 
> No. It will still break things.

Why, all fields are defined quite well. So usertools can easily get the info they
need based on 'column' number. If adding extra fields at the end breaks programs I
guess these tools should be fixed. 

RedHat kernels already have extended /proc/partitions: the sar patches...
It would ne nice to add these to the 2.5 kernel.

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
