Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285801AbRLHEAl>; Fri, 7 Dec 2001 23:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285804AbRLHEAc>; Fri, 7 Dec 2001 23:00:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285801AbRLHEAW>; Fri, 7 Dec 2001 23:00:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: File copy system call proposal
Date: 7 Dec 2001 20:00:07 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9us387$poh$1@cesium.transmeta.com>
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1007782956.355.2.camel@quinn.rcn.nmt.edu>
By author:    Quinn Harris <quinn@nmt.edu>
In newsgroup: linux.dev.kernel
> 
> All kernel copy:
> Commands like cp and install open the source and destination file using
> the open sys call.  The data from the source is copied to the
> destination by repeatedly calling the read then write sys calls.  This
> process involves copying the data in the file from kernel memory space
> to the user memory space and back again.  Note that all this copying is
> done by the kernel upon calling read or write.  I would expect if this
> can be moved completely into the kernel no memory copy operations would
> be performed by the processor by using hardware DMA.
> 

mmap(source file);
write(target file, mmap region);

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
