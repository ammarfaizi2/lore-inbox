Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVJYRsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVJYRsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJYRsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:48:04 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:8019 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932248AbVJYRsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:48:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UXYqjcL9/SJKhoz+zC2KchG2mz2JWX6Ed6wP58jei5OIlHsk1qTP/HK98sSM3zc+F7QmiJ3D34NjAkPirvMoetwtSyTKbu8yh4CvyUbsbr0Eh8Jb0234442JUmU1ovpE1hp1ugNUegNMvj906HoYfrdauL+pjLh/d0Lzirk6PEc=
Message-ID: <9a8748490510251047o354b8f01n73b0a3290bc41c76@mail.gmail.com>
Date: Tue, 25 Oct 2005 19:47:59 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] lib stringc cleanup restore useful memmove const
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051025141629.21880.42486.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051025141629.21880.42486.sendpatchset@jackhammer.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/05, Paul Jackson <pj@sgi.com> wrote:
> A couple of (char *) casts removed in a previous cleanup patch
> in lib/string.c:memmove() were actually useful, as they
> suppressed a couple of warnings:
>
Hmm, you are right, I shouldn't have missed that, my bad.


>         assignment discards qualifiers from pointer target type
>
> Fix by declaring the local variable const in the first place,
> so casts aren't needed to strip the const qualifier.
>
Looks good to me, thank you for fixing that up.


> Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
