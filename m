Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281825AbRKWAME>; Thu, 22 Nov 2001 19:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281826AbRKWALy>; Thu, 22 Nov 2001 19:11:54 -0500
Received: from ns01.netrox.net ([64.118.231.130]:11705 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281825AbRKWALl>;
	Thu, 22 Nov 2001 19:11:41 -0500
Subject: Re: [PATCH] fix compile warnings in 2.4.15pre9
From: Robert Love <rml@tech9.net>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Rich Baum <richbaum@acm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20011122165454.P1308@lynx.no>
In-Reply-To: <132A4694022@coral.indstate.edu>  <20011122165454.P1308@lynx.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 22 Nov 2001 19:03:03 -0500
Message-Id: <1006473785.1336.6.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 18:54, Andreas Dilger wrote:
> How about something like (not real patches, but you get the idea:
> 
> @@ -4691,6 +4691,7 @@
>  	OUTL_DSP (SCRIPTA_BA (np, clrack));
> +out_stuck:
>  	return;
> -out_stuck:
>  }
>  
> @@ -5226,6 +5227,7 @@
>  
> +fail:
>  	return;
> -fail:
>  }

Yes, much better.  Besides looking better, gcc _may_ generate different
code (I don't know how smart it is in this case) that has these "fall
throughs" and that would mean (a) less code and (b) less jumps -- always
a win.

	Robert Love


