Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTBGTdi>; Fri, 7 Feb 2003 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTBGTdi>; Fri, 7 Feb 2003 14:33:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64274 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266347AbTBGTdh>; Fri, 7 Feb 2003 14:33:37 -0500
Date: Fri, 7 Feb 2003 19:43:14 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
Message-ID: <20030207194314.C30927@flint.arm.linux.org.uk>
Mail-Followup-To: Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <Pine.LNX.4.44.0302071211390.6917-100000@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302071211390.6917-100000@master>; from fdavis@si.rr.com on Fri, Feb 07, 2003 at 12:13:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 12:13:04PM -0500, Frank Davis wrote:
> Hello all,
>    The following patch addresses buzilla bug # 318, and removes an
> offending semicolon. Please review for inclusion.
> 
> Regards,
> Frank
> 
> --- linux/sound/oss/vidc.c.old	2003-01-16 21:21:38.000000000 -0500
> +++ linux/sound/oss/vidc.c	2003-02-07 02:59:44.000000000 -0500
> @@ -225,7 +225,7 @@
>  			newsize = 208;
>  		if (newsize > 4096)
>  			newsize = 4096;
> -		for (new2size = 128; new2size < newsize; new2size <<= 1);
> +		for (new2size = 128; new2size < newsize; new2size <<= 1)
>  			if (new2size - newsize > newsize - (new2size >> 1))
>  				new2size >>= 1;
>  		if (new2size > 4096) {

The code is correct as it originally stood.

It looks like indent has a bug and incorrectly formats this to look wrong.
Back in 2.2 times, the code looks  like this:

		for (new2size = 128; new2size < newsize; new2size <<= 1);
		if (new2size - newsize > newsize - (new2size >> 1))
			new2size >>= 1;

and this is the intended functionality.  Please do NOT apply the patch.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

