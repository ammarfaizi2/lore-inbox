Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSFERRU>; Wed, 5 Jun 2002 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSFERRT>; Wed, 5 Jun 2002 13:17:19 -0400
Received: from ns.suse.de ([213.95.15.193]:35852 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315606AbSFERRS>;
	Wed, 5 Jun 2002 13:17:18 -0400
Date: Wed, 5 Jun 2002 19:17:19 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 i2c uses nonexistent linux/i2c-old.h
Message-ID: <20020605191719.H11945@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20279.1023240470@kao2.melbourne.sgi.com> <1023298545.2442.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 06:35:45PM +0100, Alan Cox wrote:
 > > drivers/media/video/i2c-old.c:#include <linux/i2c-old.h>
 > > drivers/media/video/saa7110.c:#include <linux/i2c-old.h>
 > > drivers/media/video/saa7111.c:#include <linux/i2c-old.h>
 > > drivers/media/video/saa7185.c:#include <linux/i2c-old.h>
 > > drivers/media/video/zr36067.c:#include <linux/i2c-old.h>
 > > drivers/media/video/zr36120.h:#include <linux/i2c-old.h>
 > > 
 > > There is no file called i2c-old.h in 2.5.20.  These only build because
 > > they pick up i2c-old.h from /usr/include/linux :(.
 > 
 > i2c-old was back compatibility for obsolete code from 2.2 into 2.4. Its
 > dead its gone, and now folks need to go fix the drivers

Which makes me wonder why it compiled for Keith.
Why is kbuild2.5 expanding <linux/foo.h> to /usr/include/linux/foo.h ?
If $sourcetree/include/linux/foo.h doesn't exist, it should stop
compiling, not look in /usr/include/ for a (obsolete/wrong) alternative.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
