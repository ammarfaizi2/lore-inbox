Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUKFOyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUKFOyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 09:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKFOyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 09:54:06 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:31220 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261397AbUKFOx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 09:53:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=k8sGrBk3V5UB/3U2nX8DakHOCbk4T6qZ8jxkm76nalmaQGutlLHtQ9EdSYDosrQaTtgPqNJi7Nly3LhQbEHBCUQl13Qf00YJrQvvv+CO8WJKP4U+qy89gK8IE+Vu8jbJebf+B0fuq8rSdSXApPH13cds+xI1ZOHkze0xy8MKJUY=
Message-ID: <8783be660411060653735238de@mail.gmail.com>
Date: Sat, 6 Nov 2004 09:53:56 -0500
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH 2/3] WIN_* -> ATA_CMD_* conversion: update WIN_* users to use ATA_CMD_*
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@pyxtechnologies.com>
In-Reply-To: <20041106035522.GA13091@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041103091101.GC22469@taniwha.stupidest.org>
	 <418AE8C0.3040205@pobox.com>
	 <58cb370e041105051635c15281@mail.gmail.com>
	 <20041106032314.GC6060@taniwha.stupidest.org>
	 <8783be660411051945252097c3@mail.gmail.com>
	 <20041106035522.GA13091@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 19:55:22 -0800, Chris Wedgwood <cw@f00f.org> wrote:
> I assume for Windows they do that for all drives?  Even older ones?

Most likely, but that doesn't imply that Windows XP works with ancient
ata drives.

> 
> I also wonder what happens with TCQ when you get an error?  Do you
> just retry everything outstanding?

My guess is yes, but I'll also bet the drive vendors have not tested
this path well.

> It probably should get fixed, there just doesn't seem to be much
> incentive to beat on the old IDE code though :( Minor cleanups seem
> worthwhile but anything intrusive I worry will break some hard-to-test
> platform for someone.

The best solution is probably to make it user selectable for now.  I
know we need the reset/set features, or any sort of error causes a
major melt down. We can default to the current behaviour, so it
shouldn't break anything.

I'll make sure some patches for this are created sometime in the next
couple of months.  I'll even try to make sure TCQ gets tested with
them if TCQ works well enough with the current code.

    Ross

    Ross
