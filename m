Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUDTWKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUDTWKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbUDTWJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:09:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:64334 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264253AbUDTTdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:33:45 -0400
Date: Tue, 20 Apr 2004 21:42:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: Support for building individual .ko's would be nice :-)
Message-ID: <20040420194247.GA6533@mars.ravnborg.org>
Mail-Followup-To: Pekka Pietikainen <pp@ee.oulu.fi>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <20040420185904.GA27037@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420185904.GA27037@ee.oulu.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 09:59:04PM +0300, Pekka Pietikainen wrote:
> I was told you're the man to bug about this :-)
> 
> Having a slow box, a vendor kernel (+ kernel-source package with config
> for it) and a need to modify one line of a module, recompile it,
> replace existing module with it and continue business as usual
> made me notice kbuild doesn't seem to have a facility for this.
> 
> What would be nice is (say)
> 
> cp configs/xxx-i686.config .config
> emacs drivers/media/dvb/frontends/ves1820.c
> make drivers/media/dvb/frontends/ves1820.ko

Use
make drivers/media/dvb/frontends/

to just compile the module.

But then you need to do an:
make modules

which will build all modules. Here you need to tweak the .config to only
specify one module, the one you want.
Sorry, no better way today.

Keep a pre-built kernel is always a good choice.

	Sam
