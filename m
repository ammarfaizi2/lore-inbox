Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290826AbSARVOa>; Fri, 18 Jan 2002 16:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290825AbSARVOV>; Fri, 18 Jan 2002 16:14:21 -0500
Received: from quark.didntduck.org ([216.43.55.190]:45327 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S290824AbSARVOJ>; Fri, 18 Jan 2002 16:14:09 -0500
Message-ID: <3C489019.3422D650@didntduck.org>
Date: Fri, 18 Jan 2002 16:14:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <raul@viadomus.com>
CC: linux-kernel@vger.kernel.org, yinlei_yu@hotmail.com
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
In-Reply-To: <E16RgGu-0005tD-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
> 
>     Hi Brian :)
> 
> >The large page size is 4MB, except in PAE mode where they are 2MB.
> >Normal pages are always 4KB.  Noting in the GDT affects the page
> >size.
> 
>     The entries in the GDT, do not set the page size for that
> descriptor? I'm certainly rusted on the i386 O:)))
> 
>     Raúl

No, there is a bit in the page directory that determines if the entry
points to a page table (with 4KB pages) or to a 4MB page.  The GDT is
only used for segmentation, which is totally seperate from paging.

--

				Brian Gerst
