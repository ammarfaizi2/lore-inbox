Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSBONIW>; Fri, 15 Feb 2002 08:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289159AbSBONIM>; Fri, 15 Feb 2002 08:08:12 -0500
Received: from elin.scali.no ([62.70.89.10]:36367 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S289326AbSBONIB>;
	Fri, 15 Feb 2002 08:08:01 -0500
Subject: Re: Stack information ...
From: Terje Eggestad <terje.eggestad@scali.com>
To: Damien Touraine <damien.touraine@limsi.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6CF4CD.4040105@limsi.fr>
In-Reply-To: <3C6CF4CD.4040105@limsi.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 15 Feb 2002 14:07:54 +0100
Message-Id: <1013778474.3998.10.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien

The current stack size is obtainable from /proc/pid/status (VmStk). 
If you need the VM addresses you need to make a hack, but you can start
by looking at the code for generation the status:
fs/proc/array.c:task_mem()

Note that with in C (gcc) you can get a hold of a bit of info:
see info gcc
	-> C extentions -> return address -> Getting the Return or Frame
Address of a Function

You can also use asm statement in C to inspect the stack, but you need
to do assembly....
 
The latter you get from /proc/.../maps and /status, and /statm (see man
proc)
also: ps -u -p pid 
VSZ is the virtual memory size, RSS is what is resident in phys memory. 

THreads is a bit trickier.

Terje

fre, 2002-02-15 kl. 12:45 skrev Damien Touraine:
> II would like to know if there is any way in Linux to monitor the stack 
> of the current program ?
> Ie : I would like to get the adress of the first element of the stack, 
> the adress of the last one, the full size of the stack and so on.
> Is-there a doc on the web on how to manage the stack ?
> 
> Moreover, I would also like to know how to get the information on the 
> virtual memory used by the current process (the size of memory currently 
> used by the process) ...
> 
> Friendly
>     Damien TOURAINE
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

