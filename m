Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274500AbRIYV1F>; Tue, 25 Sep 2001 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274185AbRIYV04>; Tue, 25 Sep 2001 17:26:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1029 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274590AbRIYV0j> convert rfc822-to-8bit; Tue, 25 Sep 2001 17:26:39 -0400
Date: Tue, 25 Sep 2001 17:03:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Juan <piernas@ditec.um.es>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bad, bad, bad VM behaviour in 2.4.10
In-Reply-To: <3BB0F483.69929A79@ditec.um.es>
Message-ID: <Pine.LNX.4.21.0109251702240.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Juan, 

It is a known problem which we are looking into.

I need some information which may help confirm a guess of mine:

Do you have swap available ?

If so, there was available anonymous memory to be swapped out ?

On Tue, 25 Sep 2001, Juan wrote:

> Hi!
> 
> My test is very simple. I have started X-Window and XMMS in order to
> listen to some songs. Then, I have executed
> 
> 	dd if=/dev/hdc1 of=/dev/null
> 
> as root within a terminal, and I have got the following a few seconds
> later:
> 
> Sep 25 22:05:55 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:00 localhost last message repeated 2 times
> Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0xf0/0) from c012ff60
> Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:00 localhost last message repeated 2 times
> Sep 25 22:06:00 localhost kernel: VM: killing process xmms
> Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:04 localhost last message repeated 11 times
> Sep 25 22:06:04 localhost kernel: VM: killing process xmms
> Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:04 localhost kernel: VM: killing process kmix
> Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:04 localhost last message repeated 2 times
> Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0xf0/0) from c012ff60
> Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:04 localhost last message repeated 3 times
> Sep 25 22:06:04 localhost kernel: VM: killing process gpm
> Sep 25 22:06:05 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:06 localhost last message repeated 6 times
> sep 25 22:06:06 localhost su(pam_unix)[2548]: session closed for user
> root
> Sep 25 22:06:06 localhost kernel: VM: killing process sendmail
> Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:07 localhost kernel: VM: killing process konsole
> Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:07 localhost kernel: VM: killing process named
> Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:07 localhost kernel: VM: killing process xmms
> Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:07 localhost last message repeated 3 times
> Sep 25 22:06:07 localhost kernel: VM: killing process ksmserver
> Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:07 localhost kernel: VM: killing process kdeinit
> Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:08 localhost kernel: VM: killing process X
> Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0xf0/0) from c012ff60
> Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> f60
> Sep 25 22:06:08 localhost last message repeated 2 times
> Sep 25 22:06:08 localhost kernel: VM: killing process kdeinit
> Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:08 localhost kernel: VM: killing process startkde
> Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> Sep 25 22:06:09 localhost kernel: VM: killing process named
> Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
> failed (gfp=0x1d2/0) from c012ff60
> 
> The /dev/hdc1 partition capacity is 6 GB. My root partition is on
> /dev/hda5. My computer is a Pentium III with 384 MB of RAM.
> 
> BTW, the same test in 2.4.6 works fine without any problem.
> 
> Regards.
> 
> 
> -- 
> D. Juan Piernas Cánovas
> Departamento de Ingeniería y Tecnología de Computadores
> Facultad de Informática. Universidad de Murcia
> Campus de Espinardo - 30080 Murcia (SPAIN)
> Tel.: +34968367657    Fax: +34968364151
> email: piernas@ditec.um.es
> PGP public key:
> http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

