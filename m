Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUFON2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUFON2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUFON2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:28:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4009 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265517AbUFON2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:28:03 -0400
Date: Tue, 15 Jun 2004 10:16:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Steven Dake <sdake@mvista.com>
Cc: Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oopses with both recent 2.4.x kernels and 2.6.x kernels
Message-ID: <20040615131650.GA13697@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel> <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087232825.28043.4.camel@persist.az.mvista.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:07:05AM -0700, Steven Dake wrote:
> Marcelo and Stian,
> 
> I have also seen this oops relating to low memory situations.  I think
> ext3 allocates some data, has a null return, sets something to null, and
> then later it is dereferenced in kwapd.
> 
> Anyone have a patch for this problem?

Steven, 

For what I remember Stian oopses were happening in random places in the VM freeing 
routines. That makes me belive what he was seeing was some kind of hardware issue, 
because otherwise the oopses would be happening in the same place (in case it was 
a software bug). The codepaths which he saw trying to access invalid addresses are 
executed flawlessly by all 2.4.x mainline users. He was also seeing oopses with v2.6.

Assuming his HW is not faulty, I can think of some driver corrupting his memory. 

Do you have any traces of the oopses you are seeing?  

Stian, you told us switched servers now, I assume the problem is gone? 
Are you still running v2.4 on that server?

Thanks!
