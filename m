Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSFTOLU>; Thu, 20 Jun 2002 10:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSFTOLT>; Thu, 20 Jun 2002 10:11:19 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37027 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313508AbSFTOLS>;
	Thu, 20 Jun 2002 10:11:18 -0400
Date: Thu, 20 Jun 2002 16:06:12 +0200
From: Dave Jones <davej@suse.de>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] Split up agpgart into per implementation files.
Message-ID: <20020620160612.I29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nicolas Aspert <Nicolas.Aspert@epfl.ch>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dri-devel@lists.sourceforge.net
References: <fa.ep8m4pv.1gkki2v@ifi.uio.no> <3D11CF69.3030103@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D11CF69.3030103@epfl.ch>; from Nicolas.Aspert@epfl.ch on Thu, Jun 20, 2002 at 02:49:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 02:49:45PM +0200, Nicolas Aspert wrote:

 > Definitely a good idea !
 > The code is much easier to read.

Exactly. It also becomes a little easier to slot in support
for new vendors, than navigating a 120kb .c file.

 > For those interested in trying this with 2.4, here is an adaptation of 
 > the patch for 2.4.19-pre10-ac2 . I did not include neither the changes 
 > made in 2.5.23 (at least they should not be here), nor the intel 460 
 > stuff (not present in 2.4).

Thanks for doing this..  I goofed the Makefile, and it doesn't build
correctly as modules under 2.5. Fixed one is at http://www.codemonkey.org.uk/Makefile
Just drop it into drivers/char/agp/ after applying my patch.
Due to build system differences, I'm not sure if your 2.4 patch also
suffers the same problem..

Oh, and agp.h has the definition of PFX below code which uses it,
and should be moved around..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
