Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbTJFA0D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTJFA0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:26:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7359 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263907AbTJFA0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:26:01 -0400
Message-ID: <3F80B68D.8090109@pobox.com>
Date: Sun, 05 Oct 2003 20:25:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Philippe Lochon <plochon.n0spam@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility
 ?
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org> <20031004192733.GA30371@gtf.org> <20031004195342.GA25328@codepoet.org> <20031005201638.GB4259@codepoet.org>
In-Reply-To: <20031005201638.GB4259@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> When I have the Bios set to compatible mode everything works --
> except for the obvious problem that I have to put my SATA drive
> onto my promise SATA card (since the ICH5 SATA is disabled).
> 
> When I have the Bios set to Enhanced mode (so the ICH5 provides
> both SATA and PATA) then my system will wedge solid as a rock.
> 
> It turns out it was locking up while loading up the ide-scsi
> kernel module.  I have
> 
>     options ide-cd ignore='hdc'


So, things work in Enchanced mode if ide-scsi module is not loaded?

And, drivers/ide is picking up your PATA devices as expected?

As a tangent, I wonder if the latest cdrecord works in 2.4 with 
'dev=/dev/hdc' ... that would elimiante the need for ide-scsi.

	Jeff



