Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTE1AVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTE1AVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:21:09 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:11282
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264461AbTE1AVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:21:07 -0400
Date: Tue, 27 May 2003 17:29:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: frahm@irsamc.ups-tlse.fr
Cc: c-d.hailfinger.kernel.2003@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
Message-ID: <20030528002945.GD23651@matchmail.com>
Mail-Followup-To: frahm@irsamc.ups-tlse.fr,
	c-d.hailfinger.kernel.2003@gmx.net, linux-kernel@vger.kernel.org
References: <3ED3EA03.8070406@gmx.net> <200305280003.h4S03q4L000448@albireo.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305280003.h4S03q4L000448@albireo.free.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:03:52AM +0200, frahm@irsamc.ups-tlse.fr wrote:
> I have now disabled "CONFIG_IDEDMA_PCI_AUTO" such that initially DMA is 
> disabled for /dev/hda and /dev/hdb. I have then enabled DMA only for
> /dev/hdb with hdparm (keeping DMA disabled for /dev/hda) but the problem
> persists and DMA for /dev/hdb will be disabled when I try to mount a
> cdrom. It seems that the DMA-setting for /dev/hda has no influence on 
> this.

Try using hdparm -d1 -X34 on /dev/hda and /dev/hdb

This will turn on DMA and use the same DMA mode for both devices.  I
wouldn't be surprised if the new IDE was more strict (maybe more spec
compliant?) than the previous version.
