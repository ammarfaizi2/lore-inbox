Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUAJQZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUAJQZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:25:22 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:61376 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S265252AbUAJQZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:25:14 -0500
Date: Sat, 10 Jan 2004 17:25:12 +0100 (CET)
From: Milan Jurik <M.Jurik@sh.cvut.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm2: compilation error
In-Reply-To: <1073751266.1146.41.camel@nidelv.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0401101719120.1196@bobek.sh.cvut.cz>
References: <Pine.LNX.4.58.0401101644010.1196@bobek.sh.cvut.cz>
 <1073751266.1146.41.camel@nidelv.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Jan 2004, Trond Myklebust wrote:

> P? lau , 10/01/2004 klokka 10:46, skreiv Milan Jurik:
> > Hi,
> >
> >     CC      fs/nfs/nfs4proc.o
> > fs/nfs/nfs4proc.c: In function `nfs4_lck_type':
> > fs/nfs/nfs4proc.c:2042: warning: control reaches end of non-void function
> > fs/nfs/nfs4proc.c: In function `nfs4_proc_setlk':
> > fs/nfs/nfs4proc.c:2189: unknown field `clientid' specified in initializer
> > fs/nfs/nfs4proc.c:2189: warning: missing braces around initializer
> > fs/nfs/nfs4proc.c:2189: warning: (near initialization for
> > `otl.lock_owner')
> > make[3]: *** [fs/nfs/nfs4proc.o] Error 1
> > make[2]: *** [fs/nfs] Error 2
> > make[1]: *** [fs] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.6.1'
> > make: *** [stamp-build] Error 2
>
> No need. I'm surprised I don't see that first warning in my own
> compiles.
>
> The second one, however appears to be a compiler bug: AFAICS
> concatenating C99 designated intializers in that manner is supported by
> the spec (and indeed my version of gcc is quite happy with it). No
> matter, though, as we can work around it.
>
> Does the following patch work for you?
>

Yes, thanks.
Btw. gcc version 2.95.4 from Debian/Linux/Woody/i386

> Cheers,
>   Trond
>
>

Best regards,

         Milan Jurik
