Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTAAPuZ>; Wed, 1 Jan 2003 10:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTAAPuZ>; Wed, 1 Jan 2003 10:50:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22277 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267268AbTAAPuX>; Wed, 1 Jan 2003 10:50:23 -0500
Date: Wed, 1 Jan 2003 10:56:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Guennadi Liakhovetski <lyakh@mail.ru>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi CD-recorder error reading burned disks
In-Reply-To: <Pine.LNX.4.44.0212312145020.3542-100000@poirot.grange>
Message-ID: <Pine.LNX.3.96.1030101105132.14470B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002, Guennadi Liakhovetski wrote:

This is caused by either the way you burn it, or the inability of cdrecord
to create a CD which doesn't do this. It's related to read-ahead, but I
don't remember the exact detail. In any case, you *may* be able to get rid
of the problem by using -pad in mkisofs, or in cdrecord. 

> After burning a CD, when trying to read I am getting the following
> behaviour:
> 
> ~> dd if=/dev/cdr of=/dev/null bs=2048
> dd: reading `/dev/cdr': Input/output error
> 176996+0 records in
> 176996+0 records out
> 
> Whereas, the same disk read on the same drive under the normal ide-driver
> works ok:
> 
> ~> dd if=/dev/hdc of=/dev/null bs=2048
> 177039+0 records in
> 177039+0 records out
> 
> Other disks can be read on this drive also under ide-scsi ok, as well as
> this disk can be read on a SCSI DVD-drive fine. Is it a known behaviour,
> or a problem in the drive / driver?
> 
> 2.4.20, drive is Benq CRW 4012A

I would say a known behaviour, but one which is only triggered by certain
CDs. Not all CDs (in my experience) do this.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

