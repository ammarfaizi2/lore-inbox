Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbSKDWif>; Mon, 4 Nov 2002 17:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSKDWif>; Mon, 4 Nov 2002 17:38:35 -0500
Received: from almesberger.net ([63.105.73.239]:15113 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262825AbSKDWie>; Mon, 4 Nov 2002 17:38:34 -0500
Date: Mon, 4 Nov 2002 19:44:46 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, Jakub Jelinek <jakub@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Message-ID: <20021104194446.B1407@almesberger.net>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua> <20021103103710.D10988@devserv.devel.redhat.com> <1036340502.29642.36.camel@irongate.swansea.linux.org.uk> <1036372893.752.11.camel@phantasy> <1036417267.1106.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036417267.1106.36.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 04, 2002 at 01:41:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> gcc actually appears to know about that case for static functions.

Hmm. gcc 3.1 inlines functions even without being marked "inline"
when using -O3 or higher. It doesn't seem to special-case plain
"static", or even single-use "static".

Is gcc 3.2 better at this ?

-falways-inline-static-singletons would be kind of nice to have.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
