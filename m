Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVFFV5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVFFV5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVFFV5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:57:11 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:41266 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261705AbVFFV5B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:57:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j3XgF7/CZkDE2Iz2/wQOF0me+7TURWgmtICEgf0Kj1sjcgfbcGcDlpYlEkr2S9Ve2kYV+BhoccbOudclV1VXI5UjlqVaUcDAArBgOtN/jk6s6A9JUblKj0P8R+RnJaxYPL3vPIz9YYdcmAIe6QwJaY074lnnUF2CrTbuvCgDlGs=
Message-ID: <9a87484905060614576c09d08d@mail.gmail.com>
Date: Mon, 6 Jun 2005 23:57:00 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.12-rc6
Cc: Pavel Machek <pavel@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
	 <20050606192654.GA3155@elf.ucw.cz>
	 <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
	 <20050606201441.GG2230@elf.ucw.cz>
	 <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 6 Jun 2005, Pavel Machek wrote:
> >
> > There is "From: Dmitry..." in the changelog. Do your script move first
> > "From:" into author header and delete it from changelog? That would
> > explain it...
> 
> Yes. But note how it doesn't even take the "first" From: line, it
> literally takes the From: line _only_ if that line is the first line in
> the email body.
> 

A lot of times I see mails getting forwarded to you/Andrew/other
maintainer by someone without adding a From: or other indication of
who was the original author, but in almost all cases the original
author is the one listed as the first Signed-off-by: since authors are
the first to sign off on a patch, so, wouldn't it make more sense to
pick the author like this ;

1) If there's a "From:" at the start of the email, use that (note: a
lot of times this actually breaks since From: is often set by
maintainers to the person who forwarded the mail, not the actual
author, but that's a matter of educating maintainers).

2) if there's no "From:" in the mail body, pick first "signed-off-by:" 

3) Fall back on email headers.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
