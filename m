Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272708AbRHaOiW>; Fri, 31 Aug 2001 10:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272707AbRHaOiM>; Fri, 31 Aug 2001 10:38:12 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:40204 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272708AbRHaOh6>; Fri, 31 Aug 2001 10:37:58 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108311437.f7VEbUF24800@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108311428.f7VEStH24660@wildsau.idv-edu.uni-linz.ac.at> from Herbert Rosmanith at "Aug 31, 1 04:28:55 pm"
To: herp@wildsau (none Herbert Rosmanith)
Date: Fri, 31 Aug 2001 16:37:29 +0200 (MET DST)
Cc: ptb@it.uc3m.es, zippel@linux-m68k.org, patl@cag.lcs.mit.edu,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which compiles to:
> 
>   :      movw $65535,-2(%ebp)
>   :      movb $-2,-3(%ebp)
>   :      xorl %eax,%eax
>   :      movw -2(%ebp),%ax
>   :      movsbl -3(%ebp),%edx
>   :      cmpl %edx,%eax
>   :      jle .L3
> 
> you see this? short and char get expanded to 32bit int (I have a x86),
> and a signed comparison can be done without danger. "jle" jumps if
> SF != OF, which accounts to "op1 < op2" in a signed compare. the
> "unsigned short" quantum gets expanded to an "unsigned int", which
                                               ^^^^^^^^^^^^^^

yikes, this should really read "signed int".

