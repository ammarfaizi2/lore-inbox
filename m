Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbQLNSQH>; Thu, 14 Dec 2000 13:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131423AbQLNSP5>; Thu, 14 Dec 2000 13:15:57 -0500
Received: from Cantor.suse.de ([194.112.123.193]:9995 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131239AbQLNSPq>;
	Thu, 14 Dec 2000 13:15:46 -0500
Date: Thu, 14 Dec 2000 18:45:17 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
Message-ID: <20001214184517.A19948@gruyere.muc.suse.de>
In-Reply-To: <200012140356.eBE3u8s42047@aslan.scsiguy.com> <E146VPa-00044k-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E146VPa-00044k-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 10:14:51AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 10:14:51AM +0000, Alan Cox wrote:
> > I'll update my patch tomorrow to restore the definition of current.
> > I do fear, however, that this will perpetuate the polution of the
> > namespace should "current" ever get cleaned up.
> 
> It can probably get cleaned up after 2.4 by making current() the actual 
> inline. For 2.2 it won't change. Consider it a feature.
> 
> It was done originally because the 2.0 code using #define based current
> generated better code than using inline functions. 2.2 upwards use a different
> (far nicer) method to find current.

The macro is still likely to generate better code. All released
gcc versions have the "inline penalty" causing bad register allocation
(maybe it'll be fixed with gcc 3's tree inliner) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
