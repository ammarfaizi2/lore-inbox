Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290316AbSAPBNH>; Tue, 15 Jan 2002 20:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSAPBMw>; Tue, 15 Jan 2002 20:12:52 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2807 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290316AbSAPBMi>;
	Tue, 15 Jan 2002 20:12:38 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201160112.g0G1CTO15187@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] Mostly PAGE_SIZE IO for RAW (FINAL VERSION)
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 15 Jan 2002 17:12:29 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org (lkml),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.21.0201151930560.27118-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Jan 15, 2002 06:41:54 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mon, 14 Jan 2002, Badari Pulavarty wrote:
> 
> > 
> > Here is the final version of the patch for doing mostly 4K size IO
> > for RAW. (2.4.17). In this version, I incorporate all the code 
> > review comments from Andrea. Thanks to Andrea.
> > 
> > Marcelo, would you please consider this patch for 2.4.18-pre4 ?
> > Please let me know, if you want me to make the patch for 2.4.18-pre3. 
> 
> I want to make sure the drivers able to do 4K IO really can do that with
> reliability.
> 
> I think we can test that on -ac kernels. 
> 
> 

Marcelo,

The issue here is not whether drivers can do 4K IO relaibly. If you
go thro filesystem, they are doing I/Os in 4K chunks. Infact, the I/Os
get coalsed into bigger size (64K etc).

The issue here is, whether drivers can handle buffer heads with
multiple sizes (b_size) in a single IO (coalsed) request. Inorder to
address this concern, I limited my patch to work only with few tested 
SCSI drivers for now. So I think, I already addressed 'safety' issue 
with untested drivers. 

But if you want to get some testing thro -ac kernels, I will be happy
to go that route. I already sent a version to Alan for consideration 
to next -ac kernel.

Regards,
Badari

