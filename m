Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTAPLOt>; Thu, 16 Jan 2003 06:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbTAPLOt>; Thu, 16 Jan 2003 06:14:49 -0500
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:37832 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S266379AbTAPLOr>; Thu, 16 Jan 2003 06:14:47 -0500
Subject: Re: Promise SuperTrak SX6000 w/ kernel 2.4.20
From: "Juergen \"George\" " Sawinski <george@mpimf-heidelberg.mpg.de>
To: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <1042712859.14520.39.camel@antares.et6.tu-harburg.de>
References: <1042712859.14520.39.camel@antares.et6.tu-harburg.de>
Content-Type: text/plain
Organization: Max-Planck Institute for Medical Research
Message-Id: <1042716221.10222.4.camel@volans>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Jan 2003 12:23:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It shouldn't find /dev/hde ... /dev/hdj (there's some problem with the
detection mechanism), as these are I2O devices, and thus it's
/dev/i2o/hd?. You have to stop the discovery process by adding 

hde=noprobe hdf=noprobe hdg=noprobe hdh=noprobe hdi=noprobe hdj=noprobe

to the lilo append variable.

BTW, I'm using 2.4.20-pre10-ac1 and it runs rock solid (despite some
1-10s stalls that seem to be controller related).

On Thu, 2003-01-16 at 11:27, Sebastian Zimmermann wrote:
> Hello,
> 
> we are using a Promise SuperTrak RAID controller together with the
> integrated i2o-drivers in the linux kernel 2.4.18. Everything works fine
> so far.
> 
> Now we wanted to upgrade to kernel 2.4.20. Configuration was unchanged.
> But now the system hangs at boot time:
> 
> When the IDE driver is loaded, it finds the system disk /dev/hda just
> like before. But with 2.4.20 the IDE driver also finds disks /dev/hde,
> /dev/hdf and so on which belong to the raid system. At this point many
> "interrupt lost" messages appear on the screen and the system hangs. It
> never gets far enough to load i2o.
> 
> Any ideas?
> 
> Thanks,
> 
> Sebastian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen "George" Sawinski                  |  Phone:  +49-6221-486-308
Max-Planck Institute for Medical Research  |  Fax:    +49-6221-486-325
Dept. of Biomedical Optics                 |  Mobile: +49-171-532 5302
Jahnstr. 29                                |  
D-69120 Heidelberg                         |  
Germany                                    |  

GPG Key/Fingerprint: 9A5F7A31/86F2E5D5EDF4D9983BDD3F23986F154F9A5F7A31

