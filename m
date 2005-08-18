Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVHRWTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVHRWTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVHRWTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:19:42 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:54867 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932494AbVHRWTl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:19:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t8uaqI+tk5z6Lt8peXM3ZYG1xA1sH7hQ4MEsMQX0lPKwdEMJVmxwXrf2R0pPDvOuixGHC3TAU1BHaJ3Vae2WbsSfKpuAGqbApxNJPK+zGjva+qjnQt1CCTDlG4mAyA7SYioVoU4Ew8Q5V6qeQXAaJr8rE/NhVgkbKnNLwliYIQw=
Message-ID: <29495f1d050818151959d2bfa7@mail.gmail.com>
Date: Thu, 18 Aug 2005 15:19:39 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] ide update
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
	 <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 18 Aug 2005, Bartlomiej Zolnierkiewicz wrote:
> >
> > 3 obvious fixes + support for 2 new controllers
> > (just new PCI IDs).
> 
> Btw, things like this:
> 
>         +#define IDEFLOPPY_TICKS_DELAY  HZ/20   /* default delay for ZIP 100 (50ms) */
> 
> are just bugs waiting to happen.

<snip>

Shouldn't this be msecs_to_jiffies(50) to avoid the rounding issues I
mentioned on LKML a bit ago?

Thanks,
Nish
