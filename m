Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUJRU1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUJRU1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJRUYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:24:02 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:61940 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267591AbUJRUWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:22:40 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VqaQxsld53eyvYAgIcbBZaGKlwYmk6Na6hKTkt2m5KLo21qCBeNWwC8J0qmaFKmNlcQz7b7/em6D9HChlk0MoDx172AD/iK0CBaZP3GM7Y/SAZ9kMmwCdGRjPoTUw2OrsVsPmyiltmSBH3OdiwpHui83X5JZ1cZ9iZamWjc9jZo
Message-ID: <58cb370e04101813221d36b793@mail.gmail.com>
Date: Mon, 18 Oct 2004 22:22:38 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Johan Groth <jgroth@dsl.pipex.com>
Subject: Re: Dma problems with Promise IDE controller
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41741CDB.5010300@dsl.pipex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41741CDB.5010300@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 20:43:23 +0100, Johan Groth <jgroth@dsl.pipex.com> wrote:
> Hi,
> I'm using a Promise controller controlling 4 IDE HD:s, setup as a sw
> raid0 array. Lately I'm getting interuppt problems that looks like this:
> 
> Oct 18 18:03:06 lion kernel: hdg: dma_timer_expiry: dma status == 0x61
> Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: status=0x51 {
> DriveReady SeekComplete Error }
> Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: error=0x40 {
> UncorrectableError }, LBAsect=53500655, sector=53500520
> Oct 18 18:03:16 lion kernel: end_request: I/O error, dev 22:01 (hdg),
> sector 53500520
> Oct 18 18:03:16 lion kernel: blk: queue c030c85c, I/O limit 4095Mb (mask
> 0xffffffff)
> Oct 18 18:03:21 lion kernel: hdg: read_intr: status=0x59 { DriveReady
> SeekComplete DataRequest Error }
> Oct 18 18:03:21 lion kernel: hdg: read_intr: error=0x40 {
> UncorrectableError }, LBAsect=53500655, sector=53500592
> Oct 18 18:03:21 lion kernel: end_request: I/O error, dev 22:01 (hdg),
> sector 53500592

...

> I thought the controller was dying so I bought a new one but with the
> same result. Can it be that hdg is dying?

Yes, you can use smartmontools (http://smartmontools.sf.net) to check the drive.
