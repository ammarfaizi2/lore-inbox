Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313533AbSDYXxO>; Thu, 25 Apr 2002 19:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313555AbSDYXxN>; Thu, 25 Apr 2002 19:53:13 -0400
Received: from pc2-redb4-0-cust106.bre.cable.ntl.com ([213.107.133.106]:33014
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S313533AbSDYXxN>; Thu, 25 Apr 2002 19:53:13 -0400
Date: Fri, 26 Apr 2002 00:52:41 +0100
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Cc: Szekeres Istvan <szekeres@webvilag.com>
Subject: Re: Assembly question
Message-ID: <20020425235240.GA28851@itsolve.co.uk>
In-Reply-To: <20020425083225.GA30247@webvilag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 10:32:25AM +0200, Szekeres Istvan wrote:

> void p_memset_dword( void *d, int b, int l )
> {
>     __asm__ ("rep\n\t"
>              "stosl\n\t"
>              :
>              : "D" (d), "a" (b), "c" (l)
>              : "memory","edi", "eax", "ecx"

An input or output operand is implicitly clobbered, so it should be written as:

	: "D" (d), "a" (b), "c" (l)
	: "memory"

Or so.

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@zealos.org; mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a17! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ !w--- r++ !t---?@ !X---?  !R- !tv b+ G+++ e>+++++ !h++* r!-- y--
