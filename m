Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVCPGcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVCPGcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 01:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCPGcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 01:32:09 -0500
Received: from users.linvision.com ([62.58.92.114]:30189 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262534AbVCPGcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 01:32:05 -0500
Date: Wed, 16 Mar 2005 07:32:04 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH][2.6.11] generic_serial.h gcc4 fix
Message-ID: <20050316063204.GA11756@bitwizard.nl>
References: <16951.6077.612190.675720@alkaid.it.uu.se> <20050315173946.GR3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315173946.GR3189@stusta.de>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 06:39:46PM +0100, Adrian Bunk wrote:
> > @@ -91,6 +91,4 @@ int  gs_setserial(struct gs_port *port, 
> >  int  gs_getserial(struct gs_port *port, struct serial_struct __user *sp);
> >  void gs_got_break(struct gs_port *port);
> >  
> > -extern int gs_debug;
> > -
> >  #endif
> 
> This patch is already in -mm for ages.
> 
> When doing such patches, -mm is usually a better basis than Linus' tree.

Note that the original reason for doing "extern int gs_debug" was that
sx.c used to have an ioctl to fiddle with it "live". Apparently
someone removed that piece of useful, but(t) ugly code, as it is no
longer there.

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
