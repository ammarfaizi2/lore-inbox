Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLWLia>; Sat, 23 Dec 2000 06:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLWLiU>; Sat, 23 Dec 2000 06:38:20 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:20997 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129391AbQLWLiO>; Sat, 23 Dec 2000 06:38:14 -0500
Date: Sat, 23 Dec 2000 12:04:54 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Michael Chen <michaelc@turbolinux.com.cn>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001223120454.L25239@arthur.ubicom.tudelft.nl>
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn>; from linux-kernel@vger.kernel.org on Thu, Dec 23, 1999 at 05:24:43PM +0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 1999 at 05:24:43PM +0800, michael chen wrote:
>         I found that when I compiled the 2.4 kernel with the option
>     of Pentium III or Pentium 4 on a Celeron's PC, it could cause  the
>     system hang at very beginning boot stage, and I found the problem
>     is cause by the fact that Intel Celeron doesn't have a real memory
>     barrier,but when you choose the Pentium III option, the kernel
>     assume the processor has a real memory barrier.

I think there is some confusion in the name "Celeron". AFAIK there are
two kinds of Celerons: the original PII based Celeron, or the newer
PIII based Celeron. My laptop has a PIII (Coppermine) based Celeron,
and it boots perfectly well without your patch. 

If you are using a PII based Celeron, you should compile the kernel
with support for the "Pentium-Pro/Celeron/Pentium-II". You certainly
should not try to run a kernel with support for P4 on a "lower" CPU,
read the documentation about CONFIG_M386 in Documentation/Configure.help
for more information.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
