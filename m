Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291449AbSCAWWd>; Fri, 1 Mar 2002 17:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293111AbSCAWWX>; Fri, 1 Mar 2002 17:22:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48388 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292846AbSCAWWL>;
	Fri, 1 Mar 2002 17:22:11 -0500
Message-ID: <3C7FFEBA.CBC44AA@zip.com.au>
Date: Fri, 01 Mar 2002 14:20:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andrea_ferraris@libero.it
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.18 OOPSes
In-Reply-To: <200203010955.BAA00986@adam.yggdrasil.com>,
		<200203010955.BAA00986@adam.yggdrasil.com> <02030122482308.12079@af>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Ferraris wrote:
> 
> The PC is a P II 200Mhz with 128 MB RAM and a Promise ATA/66
> ...
> Unable to handle kernel NULL pointer dereference at virtual address 00000800
> ...
> >>EIP; c012e9c4 <__remove_from_queues+14/30>   <=====
> 

__remove_from_queues expected a null pointer, or a valid one.  0x00000800 is
neither.  It's a null pointer which has had a bit flip.

Most likely, the poor old pII-200 is wearing out.

-
