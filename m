Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270036AbRHYReD>; Sat, 25 Aug 2001 13:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270025AbRHYRdx>; Sat, 25 Aug 2001 13:33:53 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:7437 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S269909AbRHYRdo>; Sat, 25 Aug 2001 13:33:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Mikael Pettersson <mikpe@csd.uu.se>, ionut@cs.columbia.edu
Subject: Re: [PATCH,RFC] make ide-scsi more selective
Date: Sat, 25 Aug 2001 13:33:58 -0400
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200108251210.OAA25028@harpo.it.uu.se>
In-Reply-To: <200108251210.OAA25028@harpo.it.uu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825173350Z269909-760+5944@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 August 2001 08:10, Mikael Pettersson wrote:


> On Sat, 25 Aug 2001 02:56:20 -0400 (EDT), Ion Badulescu wrote:
> >I've concocted another patch, which includes my previous one and
> >implements Mikael's idea somewhat more consistently. It adds another
> >option, "noscsi", so that by saying hdX=noscsi on the kernel command line
> >the user can prevent the ide-scsi driver from ever claiming that drive.
> >
> >So:
> >- by default it's first come, first served
> >- hdX=scsi means only the ide-scsi driver can claim hdX
> >- hdX=noscsi means the ide-scsi driver must not claim hdX ever
> >
> >Sounds good? If so, please apply, it makes many CDR users' lives easier.
>
> Looks fine to me. Tested briefly and it does get the job done.
>
> /Mikael
>
> p.s. anyone know if cdrecord will ever support ATAPI CDRs natively?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Is there something wrong with making the Atapi cdrom driver as module and 
then loading that with an ignore hdX then loading the ide-scsi module?  That 
doesn't seem hard at all.  just two pretty lines in /etc/modules.  Just make 
both drivers modular.   otherwise you have people needing to do boot 
arguments through lilo.  


and andre had a patch at one time that was supposed to do something like 
allow you to use the recording function of ide CDR's without the scsi layer.  
Not sure if it was complete or even really working but i tried it once.  
Maybe you can ask him if it's possible.  
