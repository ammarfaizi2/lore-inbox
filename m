Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVHORl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVHORl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVHORl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:41:26 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:35133 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964832AbVHORlZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:41:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rs3sPAGjtGgJSHrj1GSDQsS8AImdjPTYHUfW+S/rlgsgk8FyUYVa7Xf7UiMXXQ4f91GXP2rjrNbZ4/+vNpfeGSpXitR3AtdvqqK27YUObdupN3ogU8dshRHx8dK+NCy8oUgNT5xpN1Zvdmle5/97m6TccQ6MHOOExY+okYKRt6k=
Message-ID: <a762e240508151041597c84fc@mail.gmail.com>
Date: Mon, 15 Aug 2005 10:41:22 -0700
From: Keith Mannthey <kmannth@gmail.com>
To: "Srinivasan, Usha" <Usha.Srinivasan@unisys.com>
Subject: Re: 2.6.12.3 boot problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <94C8C9E8B25F564F95185BDA64AB05F601F9A9B1@USTR-EXCH5.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94C8C9E8B25F564F95185BDA64AB05F601F9A9B1@USTR-EXCH5.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Srinivasan, Usha <Usha.Srinivasan@unisys.com> wrote:
> Hello,
> 
> I have been successfully running 2.6.11 under Red Hat RHEL4 environment
> with no problems at all.  I needed to switch to 2.6.12 and chose
> 2.6.12.3.  However, I am having problems booting 2.6.12.3.  My SCSI HBAs
> & disks are not being found at boot time and I see these errors during
> boot:
The 2.6.11 tree is a kernel.org tree?

Are you using LVM or regular partitions?

> Red Hat nash version 4.1.18 starting
> Mkrootdev: label / not found
> Umount /sys failed: 16
> Mount: error 19 mounting ext3
> Mount: error 2 mounting none
> Switchroot: mount failed: 22
> Umount /initrd/dev failed: 2

Do you see the scsi driver find the disks?

I work around I use some times is to change my root line in the
bootloader to root=/dev/(your disk).  Lables can cause confusion.
 
> After trying many many things I have figured out what works and what
> doesn't.
> 
> Works:
> If I build scsi_mod, sd_mod, scsi_transport_spi and aic7xxxx drivers as
> built into the kernel, 2.6.12.3 boots fine.
> 
> Doesn't work:
> If I build scsi_mod, sd_mod, scsi_transport_spi and aic7xxxx drivers as
> Modules, 2.6.12.3 fails to boot.

The modules are put into an initrd correct?  You need their
functinality to boot.


Keith
