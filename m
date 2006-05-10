Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWEJEiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWEJEiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 00:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWEJEiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 00:38:05 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:45926 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964815AbWEJEiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 00:38:04 -0400
Subject: Re: [PATCH -mm] sata_vsc gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, jeremy@sgi.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44616A1C.20800@gmail.com>
References: <200605100256.k4A2u6Hu031761@dwalker1.mvista.com>
	 <44616A1C.20800@gmail.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 21:38:00 -0700
Message-Id: <1147235880.21536.53.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 13:20 +0900, Tejun Heo wrote:
> Daniel Walker wrote:
> > Fixes the following warning,
> > 
> > drivers/scsi/sata_vsc.c:152: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:153: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:154: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:155: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:156: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:158: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:159: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:160: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:161: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:162: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:166: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c: In function 'vsc_sata_tf_read':
> > drivers/scsi/sata_vsc.c:178: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:179: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:180: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:181: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:182: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:183: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c: In function 'vsc_sata_setup_port':
> > drivers/scsi/sata_vsc.c:320: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
> > drivers/scsi/sata_vsc.c:321: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
> > 
> > Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> > 
> 
> Hello, Daniel.
> 
> This fix comes up every so often and I have submitted almost identical 
> patch several months ago.  Unfortunately, it's not the proper fix and 
> won't be accepted.  All those read/writeX()'s and in/outX()'s are 
> scheduled (for a looooong time) to be converted to new unified 
> ioread/writeX()'s.  Things are in progress (well, or halt) in the #iomap 
> branch of libata-dev devel tree.  libata needs some updates in host 
> initialization part for this conversion to complete.

I guess subconsciously I knew as much, but I've seen warning like these
during compiles for a very very very long time .. Considering how
trivial it is to silence them I don't see why it shouldn't be accepted .
The "right" fix should have arrived by now ..

Daniel

