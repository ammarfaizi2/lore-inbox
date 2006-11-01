Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752281AbWKASim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbWKASim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbWKASil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:38:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14859 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752281AbWKASil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:38:41 -0500
Date: Wed, 1 Nov 2006 19:38:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: Alan Cox <alan@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.19 patch] drivers/block/aoe/aoedev.c: fix NULL dereference
Message-ID: <20061101183840.GG27968@stusta.de>
References: <20061101004025.GY27968@stusta.de> <20061101163628.GC20570@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101163628.GC20570@coraid.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 11:36:28AM -0500, Ed L. Cashin wrote:
> On Wed, Nov 01, 2006 at 01:40:25AM +0100, Adrian Bunk wrote:
> > This patch fixes a NULL dereference introduced by
> > commit e407a7f6cd143b3ab4eb3d7e1cf882e96b710eb5:
> > 
> > This quite unusual error handling through a switch introduces NULL 
> > dereferences if exactly one of the two k{c,z}alloc's failed.
> 
> Hmm.  If exactly one of the two fails, then the value of the switch
> conditional is 1 (well, certainly not zero).  It will jump over the
> zero case, and there's a return in the default case, so I'm having
> trouble seeing the danger.
> 
> What exactly is Coverity saying?  That would be interesting to know.

The Coverity checker was wrong in this case, and I didn't spot it when 
checking since the code is really confusing.

>   Ed L Cashin <ecashin@coraid.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

