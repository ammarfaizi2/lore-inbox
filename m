Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272505AbRH3Vth>; Thu, 30 Aug 2001 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272498AbRH3Vt2>; Thu, 30 Aug 2001 17:49:28 -0400
Received: from pc1-redb4-0-cust197.bre.cable.ntl.com ([213.105.85.197]:2558
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S272505AbRH3VtQ>; Thu, 30 Aug 2001 17:49:16 -0400
Date: Thu, 30 Aug 2001 22:49:27 +0100
From: Mark Zealey <mark@itsolve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010830224927.A16981@itsolve.co.uk>
In-Reply-To: <10868.999206096@redhat.com> <200108302132.f7ULWt221345@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108302132.f7ULWt221345@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Aug 30, 2001 at 11:32:55PM +0200
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.sourceforge.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 11:32:55PM +0200, Peter T. Breuer wrote:

> Now I think of it, I suppose
> 
>     unsafe_min_or_max_at_line_##__LINE__()
> 
> will definitely evoke a meaningful link error.

umm, no, the ## is removed and you are left with:
undefined reference to `unsafe_min_or_max_at_line___LINE__'

The best I can think of would be something like:
asm(".unsafe_use_of_min_or_max_in_" __FUNCTION__)

which would not give you the line number, as the line number is only avalable in
integer form, I doubt you will be able to get that very well. The assembler will
give a line in relation to the asm, rather than the C, which is not what you
want...

> I still suspect that illegal assembler will do the job, since it must
> be treated after gcc has produced assembler itself and line references
> must still be present then for the assembler to be able to give meaningful
> error messages (;), but assembler is not something I write, so someone
> else needs to say.

Those are in relation to the assembler, not the C code..

-- 

Mark Zealey
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
