Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272522AbRH3WOH>; Thu, 30 Aug 2001 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272523AbRH3WN5>; Thu, 30 Aug 2001 18:13:57 -0400
Received: from pc1-redb4-0-cust197.bre.cable.ntl.com ([213.105.85.197]:51182
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S272522AbRH3WNs>; Thu, 30 Aug 2001 18:13:48 -0400
Date: Thu, 30 Aug 2001 23:14:02 +0100
From: Mark Zealey <mark@itsolve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010830231402.D16981@itsolve.co.uk>
In-Reply-To: <20010830224927.A16981@itsolve.co.uk> <200108302206.f7UM6MG26122@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108302206.f7UM6MG26122@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Fri, Aug 31, 2001 at 12:06:22AM +0200
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.sourceforge.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 12:06:22AM +0200, Peter T. Breuer wrote:

>     #define LINE(x,y) x##y
>     ...
>     LINE(unsafe_min_or_max_at_line_,__LINE__)()

Hmm, that doesn't work here, but I think the asm one would work better anyway.

>   #define stringify(x) #x
>   asm(".unsafe_use_of_min_or_max_at_line_" stringify(__LINE__))

Yep, I missed this. The following will work:

#define _S(x) #x
#define S(x) x
asm(".error_with_min_or_max_at_line_" S(__LINE__))

-- 

Mark Zealey
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
