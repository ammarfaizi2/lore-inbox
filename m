Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272516AbRH3WG1>; Thu, 30 Aug 2001 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272519AbRH3WGR>; Thu, 30 Aug 2001 18:06:17 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:27914 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272516AbRH3WGF>;
	Thu, 30 Aug 2001 18:06:05 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302206.f7UM6MG26122@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010830224927.A16981@itsolve.co.uk> from "Mark Zealey" at "Aug
 30, 2001 10:49:27 pm"
To: "Mark Zealey" <mark@itsolve.co.uk>
Date: Fri, 31 Aug 2001 00:06:22 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark Zealey wrote:"
> On Thu, Aug 30, 2001 at 11:32:55PM +0200, Peter T. Breuer wrote:
> >     unsafe_min_or_max_at_line_##__LINE__()
> > 
> umm, no, the ## is removed and you are left with:
> undefined reference to `unsafe_min_or_max_at_line___LINE__'

Not sure about that ... I'm willing to believe you, but even so surely
it would be possible to get round with the usual kind of cpp fiddle?
Something like

    #define LINE(x,y) x##y
    ...
    LINE(unsafe_min_or_max_at_line_,__LINE__)()

> The best I can think of would be something like:
> asm(".unsafe_use_of_min_or_max_in_" __FUNCTION__)
> 
> which would not give you the line number, as the line number is only avalable in

  #define stringify(x) #x
  asm(".unsafe_use_of_min_or_max_at_line_" stringify(__LINE__))

> integer form, I doubt you will be able to get that very well. The assembler will

Peter
