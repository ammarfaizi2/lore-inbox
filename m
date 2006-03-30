Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWC3JKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWC3JKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWC3JKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:10:50 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:12177 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbWC3JKt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:10:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=feinGMFvBMehwPSVuhzsyDWsqH0dQdOrsU4exb6Rv9xbYlhcloat9dmu9SL3c8wQoI2T4PtfwYgKckb2R7yUWme7AMPn0Sd6OD+cCvrroSxSe0pe2BMGq8cM+r/WxrmFAQg0mdQgn2On1CH9TLBq2UehsKOfBIbV4TdHzVPTpe8=
Message-ID: <58cb370e0603300110p43c33040hdb95a8c871f4b50d@mail.gmail.com>
Date: Thu, 30 Mar 2006 11:10:49 +0200
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: why no option for 'ide=nocddma'?
Cc: "Jack Howarth" <howarth@bromo.msbb.uc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1143396437.2540.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060324184338.7A87511003E@bromo.msbb.uc.edu>
	 <1143396437.2540.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-03-24 at 13:43 -0500, Jack Howarth wrote:
> > release unless users pass the 'ide=nodma' kernel option. If
> > the problem with CDs using dma isn't going to be fully resolved,
> > why can't we have a 'ide=nocddma' kernel option that would only
>
> It is nothing to do with DMA. See the postings in 2004 on the subject.
> EOF handling in the block layer and IDE layer don't work for the case
> where the size of a block device is not precisely defined
>
> None fo the current block layer maintainers care about fixing it and
> nobody else has submitted changes. Feel free to do that.
>
> Fortunately the drivers/ide layer will hopefully be going away soon

EOF handling error has nothing to do with IDE layer,
the same problem can be reproduced using libata+PATA patches.

Bartlomiej
