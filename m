Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281144AbRKKWeD>; Sun, 11 Nov 2001 17:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281138AbRKKWdx>; Sun, 11 Nov 2001 17:33:53 -0500
Received: from pc3-redb4-0-cust118.bre.cable.ntl.com ([213.106.223.118]:3570
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S281146AbRKKWde>; Sun, 11 Nov 2001 17:33:34 -0500
Date: Sun, 11 Nov 2001 22:33:31 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Best kernel config for exactly 1GB ram
Message-ID: <20011111223330.B24030@itsolve.co.uk>
In-Reply-To: <3BEEE61A.6050002@uhura.rueb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEEE61A.6050002@uhura.rueb.com>; from steve@uhura.rueb.com on Sun, Nov 11, 2001 at 02:56:58PM -0600
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 02:56:58PM -0600, Steve Bergman wrote:

> Hi,
> 
> 
> I have just upgraded my athlon 1200 system to 1GB ram.  I am unclear as 
> to how I should configure the kernel for this box.  The config.help says 
>    to say no to "high memory support" if the kernel will not run on a 
> machne with more than 1GB.  When I do this I notice that my available 
> memory as reported by top is ~ 120MB less than if I say I want 4GB 
> support.  I recall that linux reserves some of the address space for 
> itself (I thought it was just 64MB).
> 
> What are the trade offs involved here?  Am I better off sacrificing a 
> bit of the physical memory for reasons of efficiency elsewhere?  When I 
> request support for up to 4GB, what exactly changes with respect to the 
> visible virtual address space that apps see, etc?
> 
> This is a desktop machine, so it's not running Oracle or anything like 
> that.  I seem to recall Linus mentioning that big databases tend to like 
> the large (3GB) virtual address space.

Personally, I'd just leave it at the default no high-mem option.

The kernel will then be able to 'see' about 960MB of the memory, so you loose
about 64MB of it, but it's not worth the kernel using bounce-buffers etc just so
you can get 64MB more memory.

IIRC there was a 2GB patch that just redefined PAGE_OFFSET or something similar,
this means that you could see all the memory, but the max virtual memory a
process could see would be 2 gig (as opposed to 3 gig with the default).

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
