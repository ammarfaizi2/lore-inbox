Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTAGPMy>; Tue, 7 Jan 2003 10:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbTAGPMy>; Tue, 7 Jan 2003 10:12:54 -0500
Received: from elin.scali.no ([62.70.89.10]:4362 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267345AbTAGPMx>;
	Tue, 7 Jan 2003 10:12:53 -0500
Date: Tue, 7 Jan 2003 16:24:36 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <1041875880.17472.47.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301070015320.16633-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Alan Cox wrote:

> > Ok I can try that, but what about the nice level of ksoftirqd ? Any 
> > specific reason for it beeing 19 (lowest priority) and not 0 (equally to 
> > most other processes in the system) ?
> 
> Its triggered (in theory but not practice) only when we are overloaded, in
> which case we want to do other *useful* work first rather than using all
> the cpu to process requests we can't fulfill
> 

I've also tried the NAPI patch for e1000 and it experience the same 
performance problem with multithreaded apps. The "NAPI-HOWTO" doesn't 
mention that this could be an issue at all. Does any of the NAPI authors 
(Jeff ?) have any comments ?

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY


