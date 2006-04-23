Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWDWHuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWDWHuj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDWHuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:50:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:2685 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751362AbWDWHuj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:50:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RY9q9hHt3y7iyeVX4KgBRluG8fOJTBcx867xbr5A3dwQ2Qan1h1FS80M+qg3dzocVqAyUzPeHGiOlNxytZClaIAnzTZmC/YNazUtavIjFF5FfhRW7445i58yG6l3d0dbLKMoT0DB5IctuqMxFxDr+RlbXf4GsJ0KCAojmmmBuGE=
Message-ID: <84144f020604230050q71001601qadd7572a9fb169ba@mail.gmail.com>
Date: Sun, 23 Apr 2006 10:50:38 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Greg KH" <greg@kroah.com>
Subject: Re: PCI device driver writing newbie trouble
Cc: "Bert Thomas" <bert@brothom.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20060422060045.GA18067@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4447A2E7.6000407@brothom.nl> <20060422060045.GA18067@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:04:07PM +0100, Bert Thomas wrote:
> > static const struct pci_device_id cif50_ids[] = {
> >         {
> >         .vendor = 0x10B5,
> >         .device = 0x9050,
> >         .subvendor = PCI_ANY_ID, //0x10B5,
> >         .subdevice = PCI_ANY_ID, //0x1080,
> >         .class = PCI_ANY_ID,
> >         .class_mask = PCI_ANY_ID
> >         },

On 4/22/06, Greg KH <greg@kroah.com> wrote:
> Try the PCI_DEVICE() macro here instead.
>
> But that should not matter, this should work, I don't know why it
> doesn't sorry.

No device class will ever match the above class and class_mask.
Changing them to zero makes it work according to Bert.

                                                   Pekka
