Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRABRq5>; Tue, 2 Jan 2001 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130349AbRABRqs>; Tue, 2 Jan 2001 12:46:48 -0500
Received: from Cantor.suse.de ([194.112.123.193]:32772 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130163AbRABRqm>;
	Tue, 2 Jan 2001 12:46:42 -0500
Date: Tue, 2 Jan 2001 18:16:14 +0100
From: Hubert Mantel <mantel@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <device@lanana.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Frame Buffer Device Development 
	<linux-fbdev@vuser.vu.union.edu>,
        A2232@gmx.net, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devices.txt bugs
Message-ID: <20010102181614.G27745@suse.de>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	"H. Peter Anvin" <device@lanana.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
	A2232@gmx.net,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10101021122180.7140-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.05.10101021122180.7140-100000@callisto.of.borg>; from geert@linux-m68k.org on Tue, Jan 02, 2001 at 11:27:33AM +0100
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.2.16
X-PGP-Key: 1024D/B0DFF780, 1024R/CB848DFD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 02, Geert Uytterhoeven wrote:

> This patch fixes two things:
> 
>   - Correct the minor numbers for the frame buffer devices.  We have room for
>     32 frame buffers since about one year, with more room for future expansion
>     to 256.  (promised to go in by HPA on Fri, 24 Mar 2000 01:47:05 -0800).
> 
>   - Fix a typo in the minors for the A2232 serial card
> 
> --- linux-2.4.0-current/Documentation/devices.txt.orig	Mon Jan  1 23:30:06 2001
> +++ linux-2.4.0-current/Documentation/devices.txt	Tue Jan  2 11:16:42 2001
> @@ -660,6 +660,12 @@
>  
>   29 char	Universal frame buffer
>  		  0 = /dev/fb0		First frame buffer
> +		  1 = /dev/fb1		Second frame buffer
> +		    ...
> +		 31 = /dev/fb31		32nd frame buffer
> +
> +		Backward compatibility aliases {2.6}
> +
>  		 32 = /dev/fb1		Second frame buffer

How is this supposed to work? /dev/fb1 can either be 29,1 or 29,32. But
not both at the same time.

[...]

> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
