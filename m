Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSCVGgd>; Fri, 22 Mar 2002 01:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312695AbSCVGgX>; Fri, 22 Mar 2002 01:36:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:61446
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312694AbSCVGgT>; Fri, 22 Mar 2002 01:36:19 -0500
Date: Thu, 21 Mar 2002 22:35:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: CaT <cat@zip.com.au>
cc: Stephen Williams <mrsteve@midsouth.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.19pre3-ac5
In-Reply-To: <20020322061116.GO880@zip.com.au>
Message-ID: <Pine.LNX.4.10.10203212235160.9319-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NO, just that one line 790

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 22 Mar 2002, CaT wrote:

> On Thu, Mar 21, 2002 at 09:23:36PM -0800, Andre Hedrick wrote:
> > It is a BUG() check to see if there are cases where the interrupt handler
> > is being set (re armed) while it is currently set for another event.
> > 
> > if (HWGROUP(drive)->handler != NULL)
> >      BUG();
> > ide_set_handler(drive, handler, timeout, expirey);
> > 
> > If we are reloading the handler but it was set but something else , never
> > called during a completion, and/or is dangling.  It is a typo my bad :-(
> > 
> > Edit and change it from "==" to "!="
> 
> Now I'm confused. Should that be != to ==? :) And every instance I find?
> 
> -- 
> SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
> friends that I thought would have no importance until this morning when
> I got up and saw all  the commotion in the news,"  Gallardo told a news
> conference. "It stunned me."
> Reyes told Marca that he had "felt a slight pinch."
>       -- http://www.azcentral.com/offbeat/articles/1129soccer29-ON.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

