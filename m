Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJYUle>; Fri, 25 Oct 2002 16:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJYUle>; Fri, 25 Oct 2002 16:41:34 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:46854 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261581AbSJYUld> convert rfc822-to-8bit; Fri, 25 Oct 2002 16:41:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Date: Fri, 25 Oct 2002 15:47:22 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D070@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Thread-Index: AcJ8ZJgxLyTbDiGVQeWEUuLfS1iv3wAAB5+A
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Oct 2002 20:47:43.0185 (UTC) FILETIME=[C403BC10:01C27C67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Oct 25 2002, Stephen Cameron wrote:
> > 
> > Add blk_rq_map_sg_one_by_one function to ll_rw_blk.c in order to allow a low 
> > level driver to map scatter gather elements from the block subsystem one 
> > at a time 
[...]
> I have to say that I think this patch is ugly, and a complete 
> duplicate of existing code. This is always bad, especially in the case of
> something not really straight forward (like blk_rq_map_sg()). A hack.

Yes, I sort of figured you'd say that.  I was just trying to get the 
ball rolling.

> 
> I can understand the need for something like this, for drivers that
> can't use a struct scatterlist directly. I'd rather do this in a
> different way, though.
[...]

Ok, I will (try to) rewrite it as you suggest.
  
> Oh, and do try to follow the style. It's
[...]

Well, it doesn't look like cpqfc, at least.
Heh, I count it as a victory that you choose such small things
to complain about.  Thanks for your time reviewing this.

-- steve
 
