Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbRGYRF5>; Wed, 25 Jul 2001 13:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268593AbRGYRFr>; Wed, 25 Jul 2001 13:05:47 -0400
Received: from free.buy.pl ([213.77.43.228]:25612 "EHLO free.buy.pl")
	by vger.kernel.org with ESMTP id <S267103AbRGYRFh>;
	Wed, 25 Jul 2001 13:05:37 -0400
Date: Wed, 25 Jul 2001 19:05:03 +0200
From: Artur Frysiak <wiget@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Why no modules for IDE chipset support?
Message-ID: <20010725190502.D29439@free.buy.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <15198.37357.879359.519563@hertz.ikp.physik.tu-darmstadt.de> <20010725113445.B25434@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010725113445.B25434@hapablap.dyn.dhs.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25, 2001 at 11:34:45AM -0500, Steven Walter wrote:
> On Wed, Jul 25, 2001 at 11:31:25AM +0200, Uwe Bonnes wrote:
> > Hallo,
> > 
> > why are the IDE chipset support driver not modularized? Is there anything
> > fundamental that inhibits using these drivers as a modules?
> 
> They are availible as modules.  See "ATA/IDE/MFM/RLL support," which is
> a tristate.  If you select that as a module, then all the chipsets you
> select for support later will be compiled into one large module.
> 
> This is probably a bad idea, though, because if you compile IDE support
> as a module, you will not be able to mount your root partition if it is
> on an IDE disk.

This is not true. If you use initrd and load ide-mod, ide-probe-mod and
ide-disk modules on it then you may mount yours root partition.
For eg. we (PLD http://www.pld.org.pl/) have modular ide, scsi, reiserfs and
ext2 (sic!). Small tool called geninitrd make initrd based on
information from /etc/fstab, /etc/modules.conf and other configuration
files.
You may grab geninitrd from ftp://ftp.pld.org.pl/software/geninitrd/

Regards
-- 
Artur Frysiak
http://www.pld.org.pl/
