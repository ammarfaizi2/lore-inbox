Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTKRFuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 00:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTKRFuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 00:50:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52233 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262063AbTKRFuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 00:50:09 -0500
Date: Tue, 18 Nov 2003 06:50:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Levon <levon@movementarian.org>
Cc: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO build modules in 2.6.0 ...
Message-ID: <20031118055007.GC1008@mars.ravnborg.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Wojciech 'Sas' Cieciwa <cieciwa@alpha.zarz.agh.edu.pl>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl> <20031117203336.GA1714@mars.ravnborg.org> <20031117235927.GA31611@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117235927.GA31611@compsoc.man.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 11:59:27PM +0000, John Levon wrote:
> On Mon, Nov 17, 2003 at 09:33:36PM +0100, Sam Ravnborg wrote:
> 
> > Use the following:
> > make -C /usr/src/linux SUBDIRS=`pwd` O=/users/cieciwa/rpm/BUILD/eagle-1.0.4/linux modules
> > 
> 
> This requires a kernel source tree empty of built files though, so it's
> really not a great solution ...

Correct - but why keep kernel trees around full of build files, when
there is a proper solution to keep them out of the src.

The problem was generated files. If a generated file were present in
the kernel source tree, it would not be built again.
This resulted in a few suprises during development, and I therefore
added the check for a kernel source tree with no built-files.
It can be avoided, but that required too much surgery in various
makefiles and include statements. So that part is 2.7 material.

	Sam
