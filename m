Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSHOF71>; Thu, 15 Aug 2002 01:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319340AbSHOF71>; Thu, 15 Aug 2002 01:59:27 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:50959 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S316582AbSHOF70> convert rfc822-to-8bit; Thu, 15 Aug 2002 01:59:26 -0400
Subject: Re: 2.4.19 compilation non-SMP fails
From: Scott Bronson <bronson@rinspin.com>
To: Francisco Javier Fernandez <serrador@arrakis.es>
Cc: Lista desarrollo Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1029380231.4484.10.camel@evangelion>
References: <1029380231.4484.10.camel@evangelion>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Aug 2002 23:02:11 -0700
Message-Id: <1029391332.1705.37.camel@emma>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to be a well-known problem.

You need to make mrproper when you flip the SMP setting.  Make sure to
save your .config...


On Wed, 2002-08-14 at 19:57, Francisco Javier Fernandez wrote:
> Compilation fails in kernel 2.4.19 when SMP support is deactivated.
> 
> 
> 
> In file included from ksyms.c:17:
> /home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h: In
> function `kstat_irqs':
> /home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h:45:
> `smp_num_cpus' undeclared (first use in this function)
> /home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h:45:
> (Each undeclared identifier is reported only once
> /home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h:45:
> for each function it appears in.)
> make[2]: *** [ksyms.o] Error 1
> make[2]: Saliendo directorio
> `/home/cyphra/Código/linux-2.4.19-core1/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Saliendo directorio
> `/home/cyphra/Código/linux-2.4.19-core1/kernel'
> make: *** [_dir_kernel] Error 2
> 
> -- 
> I do not get viruses because I do not use MS software.
> If you use Outlook then please do not put my email address in your
> address-book so that WHEN you get a virus it won't use my address in the
> From field.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


