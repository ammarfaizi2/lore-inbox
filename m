Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWAFTdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWAFTdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWAFTdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:33:38 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:35487 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932245AbWAFTdh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:33:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fb3nQUMOPoyyNxg+3EPFNVfP7nZ7PuFjp8C0DirDcqXN4+GPwnucaMXkPog8IP5pS+uepzNM9GMZiacHOA5uisA9nfPCBpSKddCHKCC1qUHq47+SbxVbBOs+b4ryAnl9fP/Fxs0Y6oS3/AF1me/EBkHp9wgS5WXfuuKOc5lJLso=
Message-ID: <b6c5339f0601061133r3653af33h89a0ad7b44f5f94a@mail.gmail.com>
Date: Fri, 6 Jan 2006 14:33:36 -0500
From: Bob Copeland <email@bobcopeland.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: dual line backtraces for i386.
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Dave Jones <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601062016550.28630@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601061338_MC3-1-B567-4FDD@compuserve.com>
	 <Pine.LNX.4.61.0601062016550.28630@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> >                         printk(space == 0 ? "     " : "\n");
> >> >                         space = !space;
> >>
> >> readability ?
> >
> >Well, if I were going for _un_readability I'd have suggested:
> >
> >        printk(space = !space ? "     " : "\n");
>
> Anyone voting for "\t" instead of "     "?

Sure: if you use '\t' then you can do:

printk("%c", 9+space++);
space &= 1;

No branches ;)
