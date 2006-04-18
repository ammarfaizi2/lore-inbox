Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDRMNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDRMNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWDRMNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:13:24 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:39213 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750825AbWDRMNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:13:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Tlw+lkGzfnQxMbUvwmmDHw2FjAiY2f2hYYndbcVbouDw92F5nusJGMaAd3Nye88aSYGLPOccBF6HZkGNWLGU76KWqEMtGqREg+Z4lBgqHZ1KGD5AhjdlBSLLrOYPxJIlONYMv6Zb4/amMx1Mh8buBFNtgBYGFdRYe75rLepe2vw=
Date: Tue, 18 Apr 2006 21:13:26 +0900
From: Tejun Heo <htejun@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, Fabio Comolli <fabio.comolli@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Schedule for adding pata to kernel?
Message-ID: <20060418121326.GB25726@htj.dyndns.org>
References: <1142869095.20050.32.camel@localhost.localdomain> <4422F10B.9080608@bootc.net> <44266499.3070809@t-online.de> <1143393969.2540.5.camel@localhost.localdomain> <b637ec0b0604180444y7828ac5aobb349324f87201c2@mail.gmail.com> <1145361613.18736.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145361613.18736.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

[adding Jeff and linux-ide to cc list]

On Tue, Apr 18, 2006 at 01:00:13PM +0100, Alan Cox wrote:
> On Maw, 2006-04-18 at 13:44 +0200, Fabio Comolli wrote:
> > In case PIIX/ICH driver should not make it in 2.6.17, are you planning
> > to release patches for 2.6.17-rc release cycle?
> 
> I've been on holiday and am now tied up in other work until the start of
> May, at which point Jeff goes off and gets married so there may be some
> delay.
> 
> 2.6.17-rc actually has 95% of the stuff needed to drop the PATA drivers
> in and I will try to do patches at least versus 2.6.17 final. The -rcs
> will depend upon available time and also what gets integrated that
> causes additional work (notably Tejun Ho's stuff will make much merge

BTW, my name is Tejun Heo.  Tejun Ho sounds horrible in Korean.

> work, although its work I'm very glad to do as the improvements and
> hotplug support are all needed).

I'm currently working on port multiplier support.  My working tree now
successfully probes and attaches all devices over the PM and I'm
currently trying to get EH and hotplug to work with it nicely.
EH/hotplug are being changed to support PM.  Effects on LLDDs are
minimal but you can probably save some work by waiting for the next
round of patches before porting to new EH.

I think/hope this can be finished in this week and bombard Jeff with
patches (updated EH, NCQ, hotplug and PM) before the weekend, so that
Jeff can have some time to review and hopefully merge some of it into
#upstream before he goes off on honeymoon.  In some convoluted way,
the patches will be my marriage gift, heh heh.

Jeff, *BIG* congratulations.  I wish you a great marriage.

Thanks.

-- 
tejun
