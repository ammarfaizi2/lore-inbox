Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbRFYIOq>; Mon, 25 Jun 2001 04:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbRFYIOf>; Mon, 25 Jun 2001 04:14:35 -0400
Received: from sky.irisa.fr ([131.254.60.147]:20424 "EHLO sky.irisa.fr")
	by vger.kernel.org with ESMTP id <S261515AbRFYIOU>;
	Mon, 25 Jun 2001 04:14:20 -0400
Message-ID: <3B36F2D1.175CD2E@irisa.fr>
Date: Mon, 25 Jun 2001 10:14:09 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA, Campus de Beaulieu, 35042 Rennes Cedex, FRANCE
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux fbdev <Linux-fbdev-devel@lists.sourceforge.net>
CC: James Simmons <jsimmons@transvirtual.com>,
        Romain Dolbeau <dolbeaur@club-internet.fr>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbgen & multiple RGBA
In-Reply-To: <Pine.LNX.4.10.10106220926460.9835-100000@transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > the attached patch fix a problem with fbgen when changing the
> > RGBA components but not the depth ; fbgen would not change
> > the colormap in this case, where it should.
> 
> It would be much easier to use a memcmp.

For the color component, yes, but you can't use a memcmp
on the 'fb_var_screeninfo', as some member of the struct
are irrelevant to colormap switching (you don't want
to reinstall the colormap if only the refresh rate changed,
for instance).

-- 
DOLBEAU Romain               | l'histoire est entierement vraie, puisque
ENS Cachan / Ker Lann        |     je l'ai imaginee d'un bout a l'autre
dolbeau@irisa.fr             |           -- Boris Vian
