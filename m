Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTE1IvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTE1IvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:51:10 -0400
Received: from toulouse-4-a7-62-147-201-115.dial.proxad.net ([62.147.201.115]:2944
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S264632AbTE1IvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:51:09 -0400
Message-Id: <200305280901.h4S91C6C000492@albireo.free.fr>
Date: Wed, 28 May 2003 11:01:12 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Re: 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
To: mfedyk@matchmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030528002945.GD23651@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 May, Mike Fedyk wrote:
> On Wed, May 28, 2003 at 02:03:52AM +0200, frahm@irsamc.ups-tlse.fr wrote:
>> I have now disabled "CONFIG_IDEDMA_PCI_AUTO" such that initially DMA is 
>> disabled for /dev/hda and /dev/hdb. I have then enabled DMA only for
>> /dev/hdb with hdparm (keeping DMA disabled for /dev/hda) but the problem
>> persists and DMA for /dev/hdb will be disabled when I try to mount a
>> cdrom. It seems that the DMA-setting for /dev/hda has no influence on 
>> this.
> 
> Try using hdparm -d1 -X34 on /dev/hda and /dev/hdb
> 
> This will turn on DMA and use the same DMA mode for both devices.  I
> wouldn't be surprised if the new IDE was more strict (maybe more spec
> compliant?) than the previous version.

I have just tried, there is no change. DMA will be disabled when trying 
to mount a cdrom while DMA for the harddisk seems ok.

Klaus Frahm

e-mail : frahm@irsamc.ups-tlse.fr


