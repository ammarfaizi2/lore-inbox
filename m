Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbSKPXkF>; Sat, 16 Nov 2002 18:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbSKPXkF>; Sat, 16 Nov 2002 18:40:05 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:20212 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267406AbSKPXkE>; Sat, 16 Nov 2002 18:40:04 -0500
Message-ID: <3DD6DE32.60503@kegel.com>
Date: Sat, 16 Nov 2002 16:09:22 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com>	<20021116151102.GI19015@higherplane.net> <3DD6B2C5.3010303@pobox.com>	<20021116213732.GO24641@conectiva.com.br> 	<20021116214250.GQ24641@conectiva.com.br> <1037490677.24843.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>Em Sat, Nov 16, 2002 at 04:04:05PM -0500, Jeff Garzik escreveu:
>>>
>>>>About the only thing WRT menuconfig I would be ok with is commenting out 
>>>>majorly broken drivers until they are fixed...
> 
> Thats basically what "OBSOLETE" is

So how 'bout this:

* mark all drivers that don't compile OBSOLETE.  That keeps us from
   trying to fix drivers without having hardware to test them.
   Anyone with proper hardware is invited to fix the drivers and then
   mark them non-OBSOLETE.
* make 'curyesconfig' and 'curmodconfig' compile everything that isn't OBSOLETE
* fix anything left over that keeps 'make curyesconfig'
   and 'make curmodconfig' from compiling
* maintainers try to not forward any patches to Linux that
   cause 'make curyesconfig' or 'make curmodconfig' not build
* OSDL does nightly 'curyesconfig' and 'curmodconfig builds from
   Linus's tree, and mails linux-kernel a link to the build log
   along with whether it succeeded or failed

That would give maintainers quick feedback about whether they'd
broken some obscure part of Linus's tree...

- Dan

