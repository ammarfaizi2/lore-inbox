Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVLEXSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVLEXSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVLEXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:18:07 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:53915 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964826AbVLEXSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gXw4Qz5zugN+gHKyLDcB7R5wVFjzoEL0xJ3e8KTYaMgfSp20hTc2iboV37PRv73kFOLy1TIGLGyGDnUJ/K9FjCiW2AKptRzsDMhtikU97sZMqztW/9cqKDDN8kV9e16ktURX+XaXn3RgzauZGAHytHTVs21g+wB2rCjJzLl4sOE=
Message-ID: <58cb370e0512051518j35885be1j44f7846e2d27c63d@mail.gmail.com>
Date: Tue, 6 Dec 2005 00:18:03 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Marco d'Itri" <md@linux.it>
Subject: Re: ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20051205182856.GB8827@wonderland.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203172418.GA12297@vrfy.org>
	 <58cb370e0512050024s647fdc5eg8d0c2e60dd7867dd@mail.gmail.com>
	 <20051205182856.GB8827@wonderland.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/05, Marco d'Itri <md@linux.it> wrote:
> On Dec 05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > Looks fine but what about ide-scsi driver and ide_optical media?
> The Debian hotplug script, which does the same thing, does not know
> about these modules and nobody ever complained, so if some support is

Does the hotplug script export kernel sysfs attributes?

> needed it can be added later.

The problem is that you get wrong data for "modalias" sysfs attribute
for ide-scsi module (because "modalias" is based on the media type).

Until this is issue solved I can't accept this patch.

> (And ide-scsi is dead anyway...)

ide-scsi is the only way to support some devices currently

Bartlomiej
