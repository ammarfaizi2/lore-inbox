Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280809AbRKGO43>; Wed, 7 Nov 2001 09:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280808AbRKGO4R>; Wed, 7 Nov 2001 09:56:17 -0500
Received: from corp.tivoli.com ([216.140.178.60]:45817 "EHLO corp.tivoli.com")
	by vger.kernel.org with ESMTP id <S280809AbRKGO4D>;
	Wed, 7 Nov 2001 09:56:03 -0500
Message-ID: <3BE99FB8.6070702@tiscalinet.it>
Date: Wed, 7 Nov 2001 15:55:20 -0500
From: "D'Angelo Salvatore" <dangelo.sasaman@tiscalinet.it>
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux <linux-kernel@vger.kernel.org>
Subject: Re: nfsd
In-Reply-To: <3BE96ED9.6030307@tiscalinet.it> <01110716095400.00823@nemo>
X-MIMETrack: Itemize by SMTP Server on RomeMTA/Tivoli Systems(Release 5.0.8 |June 18, 2001) at
 11/07/2001 03:55:26 PM,
	MIME-CD by Notes Server on RomeMTA/Tivoli Systems(Release 5.0.8 |June 18, 2001) at
 11/07/2001 03:55:27 PM,
	MIME-CD complete at 11/07/2001 03:55:27 PM,
	Serialize by Router on RomeMTA/Tivoli Systems(Release 5.0.8 |June 18, 2001) at
 11/07/2001 03:55:40 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I executed your procedure, but the problem still be present:

nfsd.o: unresolved symbol nfsd_linkage_Rb56858ea

vda wrote:

>On Wednesday 07 November 2001 17:26, D'Angelo Salvatore wrote:
>
>>I installed a ltmodem-6.00 drivers for my T21 Thinkpad on kernel 2.4.10.
>>
>>I run a script called autoload that try to load the compiled module that
>>need to use nfsd.
>>
>>The problem is that with my kernel configuration I am not able to load
it.
>>
>>I know that sunrpc and lockd modules are necessary and I already loaded
>>them, but when I issue the command
>>
>>    insmod nfsd
>>
>>the following message appear:
>>
>>
>>        nfsd.o: unresolved symbol nfsd_linkage
>>
>>attached there is my kernel config file.
>>
>>Please can you tell me if I need to enable some other options?
>>
>>Thanx in advance and excuse me if I submit this easy question on this
>>mail list.
>>
>
>Current kernel build system is buggy, can miscompile module dependencies.
>(It will be replaced by kbuild 2.5 soon)
>
>Do this:
>
>1) Copy away your .config form kernel dir
>2) make mrproper (cleans tree thoroughly)
>3) Copy .config back
>4) Do make oldconfig
>5) Do make dep clean bzImage modules modules_install
>6) Reboot with new kernel
>
>If your problem persist, repost your failure report to lkml.
>However, guys will likely ask you to reproduce your problem
>on the latest 2.4.x.
>--
>vda
>



