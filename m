Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVCPQkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVCPQkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCPQkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:40:43 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:29334 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261289AbVCPQke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:40:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OsnhQrR4s/YCy+RhF3g+Fmxaaaid4Ix2swjSVF6m0RNTfJvOXK0wGaF6j1aczhoi9wZyswzms3NMo742AFBE2GS+sYIwd/x0jlT76gilwXKY5tQ/pBba5tfGCa5WyvM2h9W08cC6CVlfdTMw0vxFPdNjDf+kDtCm93TuJQmFzXI=
Message-ID: <5a3ed565050316084042e00742@mail.gmail.com>
Date: Wed, 16 Mar 2005 19:40:33 +0300
From: regatta <regatta@gmail.com>
Reply-To: regatta <regatta@gmail.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: 32Bit vs 64Bit
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <423857D3.80609@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <5a3ed5650503160744730b7db4@mail.gmail.com>
	 <423857D3.80609@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My question because We ran a 32 Bit application in Sun AMD64 Optreon
with 1GB connection (Kernel 2.4 x86_64 with 8 Gb memory & 2 CPUs)  and
we had trouble time with it because the user tried to put the
application processing data in a nas box (in the network) and that
made the machine to use more than 60% of the NAS CPU and no one else
was able to access the NAS

right now we are trying to see if the problem because the AMD64 Bit is
very powerful or  is it because it has 1GB connection and the
application designed to be a bad :)




On Wed, 16 Mar 2005 16:59:15 +0100, Eric Dumazet <dada1@cosmosbay.com> wrote:
> regatta wrote:
> 
> > Hi everyone,
> >
> > I have a question about the 64Bit mode in AMD 64bit
> >
> > My question is if I run a 32Bit application in Optreon AMD 64Bit with
> > Linux 64Bit does this give my any benefit ? I mean running 32Bit
> > application in 64Bit machine with 64 Linux is it better that running
> > it in 32Bit or doesn't make any different at all ?
> >
> > Thanks
> 
> Hi
> 
> Running a 32 bits application on a x86_64 kernel gives more virtual
> address : 4GB of user memory, instead of 3GB on a standard 32bits kernel
> 
> If your application uses a lot of in-kernel ressources (like tcp
> sockets and network buffers), it also wont be constrained by the
> pressure a 32 bits kernel has on lowmem (typically 896 MB of lowmem)
> 
> If your machine has less than 2GB, running a 64bits kernel is not a
> win, because all kernel data use more ram (pointers are 64 bits
> instead of 32bits)
> 
> Eric
> 
> 


-- 
Best Regards,
--------------------
-*- If Linux doesn't have the solution, you have the wrong problem -*-
