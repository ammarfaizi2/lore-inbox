Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTADU7A>; Sat, 4 Jan 2003 15:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbTADU7A>; Sat, 4 Jan 2003 15:59:00 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:27664 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262289AbTADU67>; Sat, 4 Jan 2003 15:58:59 -0500
Date: Sat, 4 Jan 2003 21:07:29 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
In-Reply-To: <1041672313.958.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301042058240.24903-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rejected. I have put thought into it and the whole point was to not allow 
the fbdev layer to touch console data. I stand firm on this!!! The reason 
being is the core console layer is going to change the next development 
cycle. We have to change to deal with things like the PC9800 type hardware 
that support more than 512 fonts. Do we realy want to break every fbdev 
driver again. This way the breakage is once and for all. Its is also a 
pandoras box. If we place these hooks in we end up with the same crappy 
driver problem we had before. I never heard anyone every say the old api 
we clean. 

