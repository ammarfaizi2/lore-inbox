Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUITOQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUITOQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUITOQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:16:26 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:34949 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266595AbUITOQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:16:20 -0400
Date: Mon, 20 Sep 2004 16:16:19 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: DervishD <lkml@dervishd.net>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920141619.GC601@MAIL.13thfloor.at>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	DervishD <lkml@dervishd.net>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920110631.GJ5482@DervishD> <1095680326.27965.238.camel@gonzales> <20040920115942.GG5684@DervishD> <1095683552.27965.240.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1095683552.27965.240.camel@gonzales>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 02:32:32PM +0200, Xavier Bestel wrote:
> Le lun 20/09/2004 à 13:59, DervishD a écrit :
> >     Hi Xavier :)
> > 
> >  * Xavier Bestel <xavier.bestel@free.fr> dixit:
> > > > does the kernel *read* /proc/mounts contents?
> > > /proc/mounts is kernel-generated on the fly (it's alive only during the
> > > read() call).
> > 
> >     Then you can cripple it with any extra contents you want, am I
> > wrong? The kernel won't mind...
> 
> Sure.


well, yes and no, actually all those funny 'mount' options
provided by the kernel 'on the fly' are just bits which
get set (or cleared) after 'parsing' the mount options
at mount time ...

this means:

 - bad mount option, no mount
 - ignored mount option, no flag
 - known mount option, flag is set (or cleared)

of course it would be possible to 'extend' the kernel
by some 'important' flags which are _not_ used by the
kernel itself ...

HTH,
Herbert

> 	Xav
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
