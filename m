Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSC3XfO>; Sat, 30 Mar 2002 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSC3XfF>; Sat, 30 Mar 2002 18:35:05 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26884 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293347AbSC3Xey>;
	Sat, 30 Mar 2002 18:34:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre5 
In-Reply-To: Your message of "Sat, 30 Mar 2002 13:40:17 MST."
             <20020330134017.A14523@mail.harddata.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 31 Mar 2002 09:34:42 +1000
Message-ID: <11078.1017531282@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002 13:40:17 -0700, 
Michal Jaegermann <michal@harddata.com> wrote:
>
>On Fri, Mar 29, 2002 at 06:47:39PM -0300, Marcelo Tosatti wrote:
>> 
>> Here goes pre5.
>
>Tried to recompile that on Alpha and I run into module symbol
>troubles of that sort:
>
>depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 20414130 >= 000000d6
>depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 74202a2f >= 000000d6
>depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 0a2f2a20 >= 000000d6
>depmod: Bad symbol index: 20414130 >= 000000d6
>depmod: Bad symbol index: 74202a2f >= 000000d6
>depmod: Bad symbol index: 0a2f2a20 >= 000000d6

That is almost always caused by bad output from binutils.  It could be
a modutils bug but I doubt it, every previous occurrence has been a
binutils problem.  Send me (not the list) the output from
readelf -es /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o

Before sending the output, try rebuilding the kernel from scratch.  It
is unlikely to help but worth a try.

