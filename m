Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUIOKND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUIOKND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUIOKND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:13:03 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:50142 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264396AbUIOKLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:11:11 -0400
Date: Wed, 15 Sep 2004 12:11:10 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/config reducing kernel image size
Message-ID: <20040915101110.GA12585@MAIL.13thfloor.at>
Mail-Followup-To: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>,
	linux-kernel@vger.kernel.org
References: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no> <20040914172646.GA614@DervishD> <1095183412.1834.7.camel@host-81-191-110-70.bluecom.no> <20040914180124.GA624@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040914180124.GA624@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:01:24PM +0200, DervishD wrote:
>     Hi Tom :)
> 
>  * Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no> dixit:
> > > > There is no point in storing all the comments and unused options in the
> > > > kernel image. This typically reduces the config size to about 1/5th
> > > > before compressing, and to about 1/4th after compressing.
> > >     I'm with you in that there is no point in storing the comments,
> > > but I disagree about the unused options. Storing the unused options
> > > as comments is more useful than it seems ;)
> > This is why I added a config option.
> 
>     But removing the comments is a good idea. Even reformatting the
> contents, or something like that.
>  
> > >     I'm not really sure about it, but I think that the unset options
> > > are left as comments for the sake of automation. The space saving
> > > doesn't (IMHO) worth the pain.
> > I'm not sure either, but I don't know of any programs that uses this.
> 
>     Neither do I.

well, the kernel config uses it, to decide if 
some option is known, or has to be defaulted/asked

try to remove one of those 'comments' from a config
and run 'make oldconfig', you'll get asked for this
specific option ...

best,
Herbert

> > Putting this config file inside the same source tree as it was compiled
> > with, and then just starting and stopping menuconfig will restore it to
> > it's original form.
> 
>     That's true.
> 
>     Raúl Núñez de Arenas Coronado
> 
> -- 
> Linux Registered User 88736
> http://www.pleyades.net & http://raul.pleyades.net/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
