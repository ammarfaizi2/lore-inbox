Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbUJ0Qdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUJ0Qdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUJ0QaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:30:20 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:44334 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262497AbUJ0Q3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:29:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rfkfw2F96ZLfyvf7YO0nL7KNk+lhjD8VFpReJW/q2tGEvpCCT7q5EpHC8XGJn7zoJmb85k0ujyFgZgQIG1WU/G2BkVF0wMVEoOjSZZ+p8cQ8q6iCTjrY/YpqnpEf5FZGKb1anOr6gtwWh1bnE69XONfxrjTJ3bvUoO9zUAXMQLs=
Message-ID: <58cb370e041027092943037ab4@mail.gmail.com>
Date: Wed, 27 Oct 2004 18:29:38 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 12:10:50 -0400, Chuck Ebbert
<76306.1226@compuserve.com> wrote:
> On Wed, 27 Oct 2004 at 15:07:14 +0200 Bartlomiej Zolnierkiewicz wrote:
> 
> >@@ -585,7 +564,8 @@
> >       struct pci_dev *dev = hwif->pci_dev;
> >
> >       /* PDC20265 has problems with large LBA48 requests */
> >-      if (dev->device == PCI_DEVICE_ID_PROMISE_20265)
> >+      if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
> >+          (dev->device == PCI_DEVICE_ID_PROMISE_20265))
> >               hwif->rqsize = 256;
> >
> >       hwif->autodma = 0;
> 
> 
>    You forgot to update the comment...

ah, care to send a patch?

>    I added this and the smart_thresholds() fix to my 2.6.9-base patches.
> 
>    Now I have these ide fixes:
> 
>         - smart_thresholds() fix
>         - pdc202xx_old LBA48 fix
>         - accept bad Maxtor drive serial number
>         - allow drive that reports no geometry
> 
>    Should anything more really be in there?

Nope, looks like you've all critical stuff.
