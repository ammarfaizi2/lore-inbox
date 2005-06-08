Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVFHH1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVFHH1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVFHH1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 03:27:10 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:24409 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262132AbVFHH1H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 03:27:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YlvkR9K6BwqloAnYMQZ7BwTVIKoI4puVTwMyCCE6BQsbGVn0nT/YGNL3lFrURhqrNipPegdgIUMUJ1YTu+AkIVKSroAhbsC2hoog4sKRmXzgSQSM00r6kfwIJ6ItwFz78Ou5nZGiKrspJSR3crq6glmEsdPeLF/txX4JEkajBpU=
Message-ID: <58cb370e05060800276f3fc29c@mail.gmail.com>
Date: Wed, 8 Jun 2005 09:27:07 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: info@a-wing.co.uk
Subject: Re: sis5513.c patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42A621BC.7040607@a-wing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A621BC.7040607@a-wing.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> Hi,

Hi,

> I'm not sure if a similar patch has been submitted or not, but here is a
> patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L
> chipset combo.

This patch is incorrect, it adds PCI ID of SiS IDE controller (this ID 
is common for almost all SiS IDE controllers and is already present in 
sis5513_pci_tbl[]) to the table of SiS Host PCI IDs.  As a result driver 
will try to use ATA_133 on all _unknown_ IDE controllers.  You need
to add PCI ID of the Host chipset (lspci should reveal it) instead.

Thanks,
Bartlomiej
