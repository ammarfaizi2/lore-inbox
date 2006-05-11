Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWEKPnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWEKPnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWEKPnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:43:20 -0400
Received: from xenotime.net ([66.160.160.81]:19633 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030284AbWEKPnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:43:19 -0400
Date: Thu, 11 May 2006 08:45:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: ata_piix failure on ich6m
Message-Id: <20060511084541.90d4e071.rdunlap@xenotime.net>
In-Reply-To: <20060511081140.GA21594@srcf.ucam.org>
References: <20060510235650.GA20206@srcf.ucam.org>
	<44629E68.3020302@gmail.com>
	<20060511081140.GA21594@srcf.ucam.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 09:11:40 +0100 Matthew Garrett wrote:

> On Thu, May 11, 2006 at 11:16:08AM +0900, Tejun Heo wrote:
> 
> > I'm not very sure but it might be historical.  ahci got implemented 
> > after ata_piix and in the meantime ata_piix must have handled all it 
> > could.  Can you verify whether modifying the code to return -ENODEV work 
> > for your machine?  If so, that could be the correct solution but I'm a 
> > bit worried because it could change probing order or fail to enable 
> > devices it used to.  Maybe we need a hack to return -ENODEV iff ahci is 
> > there to handle the device.
> 
> I can verify that just loading ahci before ata_piix is successful, and 
> udev will load both of them since the PCI IDs match. So just having 
> ata_piix refuse to bind would solve the problem. Unfortunately I can't 
> see a way of doing this only if ahci is present if they're modular...

Does the 'combined_mode' kernel parameter help any?

---
~Randy
