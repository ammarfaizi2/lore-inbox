Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTJ0Ohq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTJ0Ohp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:37:45 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:40641 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S263189AbTJ0Oho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:37:44 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 16:37:30 +0200
User-Agent: KMail/1.5.4
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com>
In-Reply-To: <3F9ACC58.5010707@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310271537.30435.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 October 2003 21:17, Jeff Garzik wrote:
> Graphics processors are growing more general, too -- moving towards
> generic vector/data processing engines.  I bet you'll see an optimal
> model emerge where you have some sort of "JIT" for GPU microcode in
> userspace.  Multiple apps pipeline X/GL/hardware commands into the JIT,
> which in turn pipelines data and microcode commands to the GPU kernel
> driver.

These "JIT" is needed also for another reason: 

	There are contraints for GPU commands and the pipelines need to
	be modelled, like CPU piplines are modelled in a compiler. But
	more like the pipelines of some early long instruction word
	processors, where issuing to a used pipeline will cause random
	behavior and crashes. So the JIT doesn't should also emit
	synchronization points. 

With this JIT in place, there need to be just some hardware description
files (backends) and some API (GL, DirectX, X) description files
(frontends).

Now we just need some funding for that and the datasheets. Then it's
doable.

I see just one showstopper: Cheating in benchmarks isn't possible anymore.

PS: That's basically the GGI approach taken further.

Regards

Ingo Oeser


