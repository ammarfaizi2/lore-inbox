Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288066AbSACAS6>; Wed, 2 Jan 2002 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSACAR0>; Wed, 2 Jan 2002 19:17:26 -0500
Received: from pc4-redb4-0-cust129.bre.cable.ntl.com ([213.107.130.129]:6138
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S288037AbSACARK>; Wed, 2 Jan 2002 19:17:10 -0500
Date: Thu, 3 Jan 2002 00:17:07 +0000
From: Mark Zealey <mark@zealos.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020103001707.GA11746@itsolve.co.uk>
In-Reply-To: <1009649897.12942.2.camel@hh2.hhhome.at> <1009992652.1249.11.camel@wookie-laptop.pdx.osdl.net> <1009994687.12942.14.camel@hh2.hhhome.at> <1009995669.1253.17.camel@wookie-laptop.pdx.osdl.net> <1010015450.15492.19.camel@hh2.hhhome.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010015450.15492.19.camel@hh2.hhhome.at>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli1 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:50:50AM +0100, Harald Holzer wrote:

> Today i checked some memory configurations and noticed that the low
> memory decreases, when i add more memory to the system,
> and the size of reserved memory increases:
> 
> at 1GB ram, are 16,936kB low mem reserved.
> 4GB ram, 72,824kB reserved
> 8GB ram, 142,332kB reserved
> 16GB ram, 269,424kB reserved
> 32GB ram, 532,080kB reserved, usable low mem: 352 MB
> 64GB ram ?? 
> 
> Which function does the reserved memory fulfill ?
> Is it all for paging ?

Yeah, page tables mostly, they have to be kept in low-mem. It's making struct
page's for every single page in that system, and must be kept in the kernel
memory...

I'd doubt if you could get the system to boot at 64 gigs

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
