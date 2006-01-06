Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWAFWwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWAFWwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWAFWwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:52:17 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:23382 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964915AbWAFWwQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:52:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c/h/MqPSo92bE2DZ/Zfjpc6PqBVywN+Xu6uDZnpziD+Xkbni/bCLarwTDQKAsMH6D6flG037e9Q4Xyueso481VDtgYhh0OflJE5KPaY7Z3qbuHKYzl+Nur4FNrBv9K9iFXcHvHg6oocvUkApE34leY7o3Z/lhEDjW30zABZoGN4=
Message-ID: <9a8748490601061452h4b61161cie41ca9605ebef00@mail.gmail.com>
Date: Fri, 6 Jan 2006 23:52:15 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] bio: gcc warning fix.
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, axboe@suse.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601061732210.25300@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060106130729.31561730.lcapitulino@mandriva.com.br>
	 <20060106153950.GV27946@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0601061732210.25300@iabervon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 6 Jan 2006, Al Viro wrote:
>
> > On Fri, Jan 06, 2006 at 01:07:29PM -0200, Luiz Fernando Capitulino wrote:
> > >
> > >  Fixes the following gcc 4.0.2 warning:
> > >
> > > fs/bio.c: In function 'bio_alloc_bioset':
> > > fs/bio.c:167: warning: 'idx' may be used uninitialized in this function
> >
> > NAK.  There is nothing to fix except for broken logics in gcc.
> > Please, do not obfuscate correct code just to make gcc to shut up.
> > Especially for this call of warnings; gcc4 *blows* in that area.
>
> Wouldn't it be worthwhile to add -Wno-uninitialized for gcc4, since those
> warnings mostly have to be ignored (and are therefore not useful for
> finding actual uninitialized variables) and make it harder to see other
> types of warnings which might be informative?
>
> This would also reduce the number of patches submitted for correct code,
> since people wouldn't keep having to be told to ignore those warnings.
>

Hmm, the uninitialized warnings do find real bugs now and then.
Generate some noice as well, true, but won't we rather tollerate a
little noice rather than miss bugs?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
