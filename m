Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRDELux>; Thu, 5 Apr 2001 07:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRDELuo>; Thu, 5 Apr 2001 07:50:44 -0400
Received: from mail.inup.com ([194.250.46.226]:39438 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S132607AbRDELuf>;
	Thu, 5 Apr 2001 07:50:35 -0400
Date: Thu, 5 Apr 2001 13:50:21 +0200
From: christophe barbe <christophe.barbe@lineo.fr>
To: Manoj Sontakke <manojs@sasken.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
Message-ID: <20010405135021.A8969@pc8.inup.com>
In-Reply-To: <Pine.GSO.4.21.0104050147290.23164-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com>; from manojs@sasken.com on jeu, avr 05, 2001 at 16:09:14 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which kernel are you using ?
GFS use this kind of computation. And with kernel 2.2, a module divdi3.o provides all missing symbol like __divdi3.

Christophe

On jeu, 05 avr 2001 16:09:14 Manoj Sontakke wrote:
> hi
> 
> On Thu, 5 Apr 2001, Alexander Viro wrote:
> > On Thu, 5 Apr 2001, Manoj Sontakke wrote:
> > 
> > > Hi
> > > 	I am getting linker error "undefined reference to __divdi3".
> > > This is because c = a/b; where a,b,c are of type "long long"
> > > I understand this is gcc problem.
> > > 	I am doing this on a pentium with gcc -v = egcs-2.91.66
> > 
> > Don't do it in the kernel. It has nothing to gcc version.
> 
> Addition and subtraction works fine. The problem is with multiplication
> and division. I am doing this to avoid floating point calculation and
> doing fixed point calculation. The rage is large enough to need "long
> long" Any other way to achieve this?
> 
> thanks
> manoj
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
