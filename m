Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316854AbSFDWAs>; Tue, 4 Jun 2002 18:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSFDWAr>; Tue, 4 Jun 2002 18:00:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54011 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316854AbSFDWAr>; Tue, 4 Jun 2002 18:00:47 -0400
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFD36D9.931F6E1D@opersys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 00:06:17 +0100
Message-Id: <1023231977.11335.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 22:53, Karim Yaghmour wrote:
> No one said that you can't have an early domain in the pipeline that
> specifically deals with this

Since Linux can run with kernel space controlled by MMU mappings and
with a few sanity checks in the PCI mapping code it should be possible
to make it reasonably robust. It would have to corrupt its kernel page
table mappings and then corrupt itself to scribble through them to fail.

Going beyond that is hairy because you then need to virtualise the
hardware interfaces and also run the kernel in ring 3 with seperate
guarded page tables

