Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135275AbRA2Qiw>; Mon, 29 Jan 2001 11:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135286AbRA2Qin>; Mon, 29 Jan 2001 11:38:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135275AbRA2Qia>;
	Mon, 29 Jan 2001 11:38:30 -0500
Date: Mon, 29 Jan 2001 17:38:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Nathan Black <NBlack@md.aacisd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bolck Device problem or Compaq Smart array 2 problem? kernel -2.4 .0+
Message-ID: <20010129173815.C23061@suse.de>
In-Reply-To: <8FED3D71D1D2D411992A009027711D671859@md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8FED3D71D1D2D411992A009027711D671859@md>; from NBlack@md.aacisd.com on Mon, Jan 29, 2001 at 11:06:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, Nathan Black wrote:
> Here are my results.
> 
> 2.2.18- works fine. 24 MBytes/sec at 100+ gigabytes (16GB looped many times
> ( lseek64(FD,SEEK_SET,0) )).
> 
> 2.4.0 release SMP and Uniprocessor with NMI on-	Kernel oops. I can reproduce
> if necessary( oops at about 700 MB)  sometimes more, sometime less. (In
> BDFLUSH if I recall)
> 
> 2.4.0 release UniProcessor NMI off- Works like the 2.2.18
> 
> 2.4.1-pre10 & 11- Works but system becomes unusable(requires reboot) after
> completing.

Unusable how? Does it hang or oops? Does nmi and up/smp make any
differences in 2.4.1-preXX?

I did some fixes for cpq after the blk merge in 2.4.1-pre, and got
reports that it works. However, I don't have the necessary hardware
to test myself.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
