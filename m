Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSHDUcl>; Sun, 4 Aug 2002 16:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSHDUcl>; Sun, 4 Aug 2002 16:32:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:53241 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318222AbSHDUcl>; Sun, 4 Aug 2002 16:32:41 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028492596.1293.535.camel@ldb>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 22:54:35 +0100
Message-Id: <1028498075.15200.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 21:23, Luca Barbieri wrote:
> Added, with the exception that sfence is only used if CONFIG_X86_OOSTORE
> is not defined (currently never).

Ok sorry I follow what you are doing. What I don't understand is why you
are generating unneeded sfence/mfence instructions in the other cases ?

When we use MMX/SSE we need the view to be consistent anyway so the
various copying routines already handle this internally. 

