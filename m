Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUHKDrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUHKDrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUHKDrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:47:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:64172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267926AbUHKDqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:46:43 -0400
Date: Tue, 10 Aug 2004 20:46:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
In-Reply-To: <200408102342.12792.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net>
 <200408102342.12792.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2004, Gene Heskett wrote:
> 
> Linus, I hate to be a killjoy on this, but I just had to reboot again, 

Note that this is something else going on. The "obvious one-liner" can be 
an issue only with certain special XFS stuff or knfsd, neither of which 
you have.

> it was killing processes, even first the shells I had open then kmail 
> and X this time, but with nothing in the logs, and when X had quit, a 
> top in the launching shell reported nearly 250 megs free with nothing 
> in the swap.

As Andrew already requested, the only way for us to figure out what is 
wrong is to get output from you on where the memory has gone. Notably, the 
output of "/proc/meminfo" and "/proc/slabinfo". "ps axm" helps too.

If it is slow, the above will still work. Just save them away and reboot. 

		Linus
