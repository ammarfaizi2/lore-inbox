Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281046AbRKUNUv>; Wed, 21 Nov 2001 08:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281028AbRKUNUl>; Wed, 21 Nov 2001 08:20:41 -0500
Received: from [62.14.144.128] ([62.14.144.128]:5248 "EHLO ragnar-hojland.com")
	by vger.kernel.org with ESMTP id <S280998AbRKUNU1>;
	Wed, 21 Nov 2001 08:20:27 -0500
Date: Wed, 21 Nov 2001 13:31:15 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011121133115.A1451@ragnar-hojland.com>
In-Reply-To: <01112112401703.01961@nemo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <01112112401703.01961@nemo>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Nov 21, 2001 at 12:40:17PM +0000
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 12:40:17PM +0000, vda wrote:
> Hi,
> 
> Upon random browsing in the kernel tree I noticed in accel.c:
>     *a++ = byte_rev[*a]
> which isn't 100% correct C AFAIK. At least Stroustrup in his C++ book
> warns that this kind of code has to be avoided.
> Wrote a script to catch similar things all over the tree (attached).

If you wanna do this type of cleanup, you can take it one step forward;
remember that the order of evaluation of foo and bar doesn't have to be
{foo => bar} so it can be {bar => foo}  I hope gcc's behaviour doesn't
change under our feet.

	a = foo (i) + bar (j);

.. sprinkle some pointer arithmetic over there for fun ;)

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
