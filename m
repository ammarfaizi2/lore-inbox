Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbTCNNBA>; Fri, 14 Mar 2003 08:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbTCNNA7>; Fri, 14 Mar 2003 08:00:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8914
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263026AbTCNNA7>; Fri, 14 Mar 2003 08:00:59 -0500
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Oleg Drokin <green@linuxhacker.ru>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
In-Reply-To: <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua>
References: <20030313182819.GA2213@linuxhacker.ru>
	 <20030313105125.1548d67c.rddunlap@osdl.org>
	 <20030313185628.GA2485@linuxhacker.ru>
	 <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047651597.27700.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 14:19:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 09:18, Denis Vlasenko wrote:
> I don't like the whole idea that mem leak is tolerable.
> 
> Can we just add a 4 byte scratch pad status to
> struct _adpt_hba? Let it scribble there...

Its 4 bytes (+ slab overhead), its far safer if this happens to say
its gone forever. Its owned by the I2O controller now and it never
gave it back

