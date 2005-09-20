Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVITIvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVITIvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVITIvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:51:35 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:7249 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964934AbVITIvf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:51:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4DIOLgsGgXpU2f9iEzSGkv4ggYG23OFg9aJEiN3l7xA/Xa9SNpN5k622HksYuu6U40/XOkEl9oItCf4IRnb+oYOa0ceEArHzEu2jJG+8hoL2ZtXjpbCwTJ6tF9geNDvR2NzFcA/SHfOU5bn5+uneSFkAs5we9lsya2XqaOi7L8=
Message-ID: <3b8510d8050920015139d45449@mail.gmail.com>
Date: Tue, 20 Sep 2005 14:21:33 +0530
From: Thayumanavar Sachithanantham <thayumk@gmail.com>
Reply-To: thayumk@gmail.com
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: [BUG] kbuild
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200509201213.44638.dr_unique@ymg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509191432.58736.dr_unique@ymg.ru>
	 <3b8510d805092000346c27270f@mail.gmail.com>
	 <3b8510d80509200043e09eae9@mail.gmail.com>
	 <200509201213.44638.dr_unique@ymg.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
> Thayumanavar Sachithanantham wrote:
> > Let me know your results.Take care of the quotes while you change.
> 
> make -C ../../../linux-2.6.11.4-21.8
>  O=../linux-2.6.11.4-21.8-obj/i386/default /bin/sh: -c: line 0: syntax error
>  near unexpected token `('
> /bin/sh: -c: line 0: `set -e;
> .....
> 
> What symbol must be between
> -D'DUM(a)=\#a'
> and
> -D'KBUILD_MODNAME=DUM($(subst $(comma),_,$(subst -,_,$(modname))))')
> 
> ?
> 
> I tried a space, comma and no spaces, also with quotes and without any, but
> got an error above.
> 
> Here is my line:
> modname_flags  = $(if $(filter 1,$(words $(modname))),-D'DUM(a)=\#a'
> -D'KBUILD_MODNAME=DUM($(subst $(comma),_,$(subst -,_,$(modname))))')
> 
> --
> RomanU
> 

A space.
Let me know if you still get errors. Also there should be an extra
parantheses before the quote.

Thayumanavar S.
