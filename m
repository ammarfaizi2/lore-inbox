Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUHLUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUHLUld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUHLUlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:41:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32983 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268775AbUHLUkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:40:17 -0400
Date: Thu, 12 Aug 2004 16:37:54 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Message-ID: <20040812203754.GE1087@devserv.devel.redhat.com>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408101916.17489.bzolnier@elka.pw.edu.pl> <20040810182353.GA17364@devserv.devel.redhat.com> <200408121912.35507.bzolnier@elka.pw.edu.pl> <20040812185614.GC866@devserv.devel.redhat.com> <Pine.GSO.4.58.0408122122190.12534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408122122190.12534@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 09:46:56PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Also aren't you the one who has made "ide-scsi" interface non-functional
> by introducing ide_setting_sem, he? 8)
> 
> http://lkml.org/lkml/2003/2/18/146

Yeah I also removed ide-scsi interface from the -ac patches in 2.4 8)

> > I also have the it8212 working in smart but non raid now. Seems issuing an
> > LBA 48 cache flush (0xEF) crashes the firmware which is why it died on load
> > for some users.  To do that I've added hwif->raw_taskfile() so that an
> > interface can filter commands.
> 
> Ouch, they should really fix this in the firmware.

Agreed. I need to verify its not our fault yet. Either way it'll need to
stay there because most people have older firmware. One thing I need to
look at is how to find firmware versions as it seems 1.2 doesnt do LBA48

Alan

