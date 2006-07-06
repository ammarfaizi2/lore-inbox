Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWGFIdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWGFIdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWGFIdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:33:22 -0400
Received: from 1wt.eu ([62.212.114.60]:55305 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S965093AbWGFIdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:33:21 -0400
Date: Thu, 6 Jul 2006 10:33:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-kernel@vger.kernel.org, marcelo@kvack.org
Subject: Re: [PATCH-2.4] Typo in cdrom.c also in linux-2.4
Message-ID: <20060706083318.GB28233@1wt.eu>
References: <44ACC870.2000609@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ACC870.2000609@xss.co.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Jul 06, 2006 at 10:23:12AM +0200, Andreas Haumer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Marcelo,
> hi Willy,
> 
> are you aware of the discussion at
> <http://bugzilla.kernel.org/show_bug.cgi?id=2966> ?

No, I was not aware. Scary !

> The typo seems to exist in linux-2.4 too, at least in
> 2.4.32, 2.4.32-hf32.6 and 2.4.33pre3 (which is what
> I checked today)
> 
> The fix for linux-2.4 would be just like the proposed
> patch for linux-2.6 (see attachment)
> 
> Comments?

Looks fine and conform to Jens' description.
Queuing it into -upstream.

> - - andreas

Thanks,
Willy

> 
> - --
> Andreas Haumer                     | mailto:andreas@xss.co.at
> *x Software + Systeme              | http://www.xss.co.at/
> Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQFErMhbxJmyeGcXPhERAgw6AKCwDRtEyE1EK+oT/nU5v2ysQxmWqACcDh1y
> eZq4acxsutVuP68nDDcEeAE=
> =puYc
> -----END PGP SIGNATURE-----

> Index: cdrom.c
> ===================================================================
> RCS file: /home/cvs/repository/distribution/Base/linux/drivers/cdrom/cdrom.c,v
> retrieving revision 1.1.1.10
> diff -u -r1.1.1.10 cdrom.c
> --- cdrom.c	19 Jan 2005 14:09:43 -0000	1.1.1.10
> +++ cdrom.c	6 Jul 2006 08:22:06 -0000
> @@ -1259,7 +1259,7 @@
>  	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
>  	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
>  	cgc.cmd[7] = s->type;
> -	cgc.cmd[9] = cgc.buflen = 0xff;
> +	cgc.cmd[9] = cgc.buflen & 0xff;
>  
>  	if ((ret = cdo->generic_packet(cdi, &cgc)))
>  		return ret;

