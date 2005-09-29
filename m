Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVI2K3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVI2K3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 06:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVI2K3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 06:29:24 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:34020 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751266AbVI2K3X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 06:29:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=quA3HSlyRA0JZXxTfueKp5pQ7hctE76v2RtId7Tour8A4MT9mt2WfCNv74F/LZDGTFANPcOfp+304g1U3UyzQ8UH8gPVaoVa7FbsdsHT8qmA4k4Xuzga1nQfQW+ktlUi4irFBa+hbalN9DkJhDiZl7ymB9Wa6BZeO5jKnPLnO/o=
Message-ID: <58cb370e050929032935a87c72@mail.gmail.com>
Date: Thu, 29 Sep 2005 12:29:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: david.ronis@mcgill.ca
Subject: Re: problem with 2.6.13.[0-2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17206.60255.403692.773279@montroll.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17206.60255.403692.773279@montroll.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/05, David Ronis <ronis@ronispc.chem.mcgill.ca> wrote:
>
> I recently tried upgrading from 2.6.12.6 to 2.6.13.[0-2] on an HP
> pavilion zv5000 (a P4 with hyper-threading) running slackware-current.
> The configuration and build went fine and the new kernel boots;
> however, things run very very slowly.  As far as I can tell, what is
> slow are process involving any disk IO.  For example, the part of the
> boot where ldconfig is run seems to take 2-3 times as long as do
> things like remaking the X font caches, loading programs etc.
>
> This vaguely reminds me of my initial experience with this laptop,
> where I hadn't turned on CONFIG_BLK_DEV_ATIIXP, although it is now
> (see below).  If I reboot with the old kernel, things run as before.

According to this page http://web.purplefrog.com/~thoth/zv5000/
this laptop uses nForce3 chipset so you should turn on AMD/nForce
IDE driver (CONFIG_BLK_DEV_AMD74XX).  Does it help?

Bartlomiej
