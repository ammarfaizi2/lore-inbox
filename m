Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292981AbSCMLSa>; Wed, 13 Mar 2002 06:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292996AbSCMLST>; Wed, 13 Mar 2002 06:18:19 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:44046 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S292981AbSCMLSJ>;
	Wed, 13 Mar 2002 06:18:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: John Covici <covici@ccs.covici.com>
Date: Wed, 13 Mar 2002 12:15:16 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware and 2.5 kernels ?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <144DEE3C7076@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Mar 02 at 15:04, John Covici wrote:

> Hi.  I am trying to get the vmware modules to compile with the 2.5
> kernel (2.5.6-pre2). I replaced the malloc.h references with slab.h as
> there is no longer a malloc.h, but I am still getting errors with
> current->fd structures.

Get patches from usual place 
(ftp://platan.vc.cvut.cz/pub/vmware/, update8 is currently latest). You 
must have VMware 3.0, as I do not (and nobody else does AFAIK) support 
VMware 2.0 on 2.5.x kernels - you need to patch VMware binary to put 
sysinfo() call into it, instead of parsing /proc/meminfo contents, which 
changed before 2.5.1 (yes, they did not learn from 2.3.24 /proc/meminfo 
lesson :-( ) and I have no interest in fixing it in old version. 
VMware 3.1 will work on 2.5.6. I have no idea about future kernels, as 
always...

If you are using VMware on oficially unsupported kernels, please
visit nntp://news.vmware.com/vmware.for-linux.experimental, you'll find
couple of your possible questions answered there.

And as always - there is no warranty, and I have no idea whether it is
legal to use my patch in the U.S.
                                            Best regards,
                                                  Petr Vandrovec
                                                  vandrove@vc.cvut.cz
                                                        
