Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbQLRIPt>; Mon, 18 Dec 2000 03:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130331AbQLRIPi>; Mon, 18 Dec 2000 03:15:38 -0500
Received: from cassis.axialys.net ([195.115.102.11]:15876 "EHLO
	cassis.axialys.net") by vger.kernel.org with ESMTP
	id <S130208AbQLRIPU>; Mon, 18 Dec 2000 03:15:20 -0500
Date: Sun, 17 Dec 2000 17:22:37 +0100
From: Simon Huggins <huggie@earth.li>
To: linux-kernel@vger.kernel.org
Cc: twaugh@redhat.com
Subject: Re: kernel-doc minor fix
Message-ID: <20001217172237.F1301@paranoidfreak.freeserve.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, twaugh@redhat.com
In-Reply-To: <Pine.LNX.4.10.10012161636480.10851-100000@virtualro.ic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012161636480.10851-100000@virtualro.ic.ro>; from jani@virtualro.ic.ro on Sat, Dec 16, 2000 at 04:41:44PM +0200
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 04:41:44PM +0200, Jani Monoses wrote:
> --- /usr/src/linux/scripts/kernel-doc	Tue Dec 12 11:25:59 2000
> +++ kernel-doc	Sat Dec 16 15:53:17 2000
> @@ -664,10 +664,11 @@

>  ##
>  # takes a function prototype and spits out all the details
> -# stored in the global arrays/hsahes.
> +# stored in the global arrays/hashes.
>  sub dump_function {
>      my $prototype = shift @_;

> +    $prototype =~ s/^const+ //;
>      $prototype =~ s/^static+ //;
>      $prototype =~ s/^extern+ //;
>      $prototype =~ s/^inline+ //;

Since when did C accept constttttttttttttttttttt and staticcccccccc?
etc.

Should that be " +" not "+ " or is someone just trying to confuse me?
Or did someone try to mean s/foo//g by adding a +?


Yours confusedly,

Simon.

-- 
[ "Therapy is expensive. Popping bubble wrap is cheap. You choose."    ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
