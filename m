Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVLEXdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVLEXdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVLEXdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:33:20 -0500
Received: from soundwarez.org ([217.160.171.123]:34021 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964862AbVLEXdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:33:20 -0500
Date: Tue, 6 Dec 2005 00:33:18 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "Marco d'Itri" <md@linux.it>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
Message-ID: <20051205233318.GB6554@vrfy.org>
References: <20051203172418.GA12297@vrfy.org> <58cb370e0512050024s647fdc5eg8d0c2e60dd7867dd@mail.gmail.com> <20051205182856.GB8827@wonderland.linux.it> <58cb370e0512051518j35885be1j44f7846e2d27c63d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512051518j35885be1j44f7846e2d27c63d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:18:03AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/5/05, Marco d'Itri <md@linux.it> wrote:
> > On Dec 05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > > Looks fine but what about ide-scsi driver and ide_optical media?
> > The Debian hotplug script, which does the same thing, does not know
> > about these modules and nobody ever complained, so if some support is
> 
> Does the hotplug script export kernel sysfs attributes?

You mean if the hotplug script uses sysfs? It looks up the
data in /proc (which is ugly, cause you have to loop until
the /proc file arrives).

> > needed it can be added later.
> 
> The problem is that you get wrong data for "modalias" sysfs attribute
> for ide-scsi module (because "modalias" is based on the media type).
> 
> Until this is issue solved I can't accept this patch.

The correct way is probably to have the same MODULE_ALIAS() in
ide-scsi and we just control the loaded module with the module-init-tools
blacklist entry. Does that make sense to you?

Thanks,
Kay
