Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSGOQnM>; Mon, 15 Jul 2002 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSGOQnL>; Mon, 15 Jul 2002 12:43:11 -0400
Received: from ns.suse.de ([213.95.15.193]:23310 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317539AbSGOQnK>;
	Mon, 15 Jul 2002 12:43:10 -0400
Date: Mon, 15 Jul 2002 18:45:59 +0200
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020715184559.C32582@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20020711230222.GA5143@kroah.com> <agtn5j$ij2$1@penguin.transmeta.com> <20020715104629.A11096@suse.de> <3D32FB8D.6030202@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D32FB8D.6030202@mandrakesoft.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 12:42:53PM -0400, Jeff Garzik wrote:

 > >Ok, I think we can even do away with the -agp, as we're in the
 > >agp/ dircetory, which again seems to be pointless duplication.
 > 
 > modprobe is still a flat namespace :/  So it's not necessarily pointless 
 > duplication.  That's why I named the via82cxxx audio driver with the 
 > _audio suffix, to eliminate conflicts with drivers/ide/via82cxxx.c 
 > when/if it becomes directly modprobe-able.

the .o files get linked into agpgart.o
Still just one module. Christoph Hellwig proposed making each back
end a module too, which is dependant upon agpgart.o, but that's more
pain than I feel like enduring right now.. Maybe later.

Linus ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
