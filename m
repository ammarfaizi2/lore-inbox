Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTJAOdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTJAOdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:33:20 -0400
Received: from nevyn.them.org ([66.93.172.17]:11413 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261807AbTJAOdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:33:18 -0400
Date: Wed, 1 Oct 2003 10:33:10 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Message-ID: <20031001143310.GA4183@nevyn.them.org>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <E1A4WNJ-000182-00@calista.inka.de> <20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 04:34:37AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Oct 01, 2003 at 04:05:57AM +0200, Bernd Eckenfels wrote:
>  
> > > +#define MS_NODIRATIME  2048    /* Do not update directory access times */
> > > +#define MS_BIND                4096
> > > +#define MS_POSIXACL    (1<<16) /* VFS does not apply the umask */
> > 
> > can we clean that up? with shifting, without shifting, with comments and without comments? I suggest to use the linuxdoc comments mandatory for the abi files.
> 
> 
> ... and make it enum, while we are at it.  It's cleaner, it survives cpp
> and it can be handled by gdb et.al. in sane way.
> 
> Unless we really want to support pre-v7 compilers, there is no benefit
> in using #define for such constants.

... although with -g3 the GDB argument goes away; but I'm not arguing
about the surviving-cpp part.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
