Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVADQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVADQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVADQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:17:32 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:63940 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261744AbVADQQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:16:26 -0500
In-Reply-To: <Pine.GSO.4.44.0412181239400.2707-100000@sysperf.somerset.sps.mot.com>
References: <Pine.GSO.4.44.0412181239400.2707-100000@sysperf.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <138B63BE-5E6B-11D9-BC22-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       <akpm@osdl.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] Make gcapatch work for all bk transports
Date: Tue, 4 Jan 2005 10:09:56 -0600
To: "Kumar Gala" <kumar.gala@freescale.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Did you have any issues with this following change to gcapatch?  If 
not, I'll resend the patch to akpm.

- kumar

On Dec 18, 2004, at 12:42 PM, Kumar Gala wrote:

> Jeff,
>
> I didn't even think if your case.  How about extracting out the 
> transport
>  from 'bk parent -p' as a middle ground.  I dont think this will help 
> your
>  case.  If not, we can leave the script as is.
>
> - kumar
>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> diff -Nru a/Documentation/BK-usage/gcapatch 
> b/Documentation/BK-usage/gcapatch
> --- a/Documentation/BK-usage/gcapatch   2004-12-18 12:39:32 -06:00
>  +++ b/Documentation/BK-usage/gcapatch   2004-12-18 12:39:32 -06:00
>  @@ -5,4 +5,4 @@
>   # Usage: gcapatch > foo.patch
>   #
>
> -bk export -tpatch -hdu -r`bk repogca 
> bk://linux.bkbits.net/linux-2.5`,+
>  +bk export -tpatch -hdu -r$(bk repogca $(bk parent -p|cut -d: 
> -f1)://linux.bkbits.net/linux-2.5),+
>
> On Fri, 17 Dec 2004, Jeff Garzik wrote:
>
> > Kumar Gala wrote:
>  > > Andrew,
>  > >
>  > > Makes the gcapatch script work for any bk transport (including 
> http).
>  > >
>  > > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> > >
>  > > --
>  > >
>  > > diff -Nru a/Documentation/BK-usage/gcapatch
> > b/Documentation/BK-usage/gcapatch
> > > --- a/Documentation/BK-usage/gcapatch       2004-12-17 13:42:32 
> -06:00
>  > > +++ b/Documentation/BK-usage/gcapatch       2004-12-17 13:42:32 
> -06:00
>  > > @@ -5,4 +5,4 @@
>  > >  # Usage: gcapatch > foo.patch
>  > >  #
>  > >
>  > > -bk export -tpatch -hdu -r`bk repogca
>  > bk://linux.bkbits.net/linux-2.5`,+
>  > > +bk export -tpatch -hdu -r$(bk repogca $(bk parent -p)),+
>  >
>  > It's an example script, meant to be modified to suit your local 
> tastes.
>  >
>  > Your patch isn't useful for situations (such as mine :)) where you 
> have
>  > more than one level of parent, but you want to generate a patch 
> versus
>  > mainline (not the parent).
>  >
>  >       Jeff
>  >
>  >

