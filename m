Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTEEMC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTEEMC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:02:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43172
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262151AbTEEMC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:02:58 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       D.A.Fedorov@inp.nsk.su
In-Reply-To: <1052127216.2821.51.camel@pc-16.office.scali.no>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052133402.29361.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2003 12:16:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 10:33, Terje Eggestad wrote:
> 1. performance is everything. 

Then you can live with building custom patched kernels

> 2. We're making a MPI library, and as such we don't have any control
> with the application. 

LD_PRELOAD

> 3c. It's therefore necessary for HW to access user pages.

Like TV cards do. That isnt hard
 
> 4. In order to to 3, the user pages must be pinned down. 
> 5. the way MPI is written, it's not using a special malloc() to allocate
> the send receive buffers. It can't since it would break language binding
> to fortran. Thus ANY writeable user page may be used.

Well not all the pages are guaranteed DMAable, so I guess you already
lost.
 
> 10. kernel patches are impractical, I must be able to do this with std
> stock, redhat, AND suse kernels.   

So you want every vendor to screw up their kernels and the base kernel
for an obscure (but fun) corner case. Thats not a rational choice is it.
You want "performance is everything" you pay the price, don't make
everyone suffer.

