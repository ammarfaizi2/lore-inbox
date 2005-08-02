Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVHBQmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVHBQmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVHBQmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:42:09 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:52330 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261649AbVHBQmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:42:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HtkyeTCCrrrhkus719r01wKXB7KDvvd3soyZMfCwXwhcAg+4cD9iJcBSWHoTM2Q6nNUBppO4Qz57w478CoAQdKgncrdYGvMS/6/zZjJaFurVZwzcNhdco9KBSmdoUSk9Xqh3YMpT4U8BiC44S3nKOHirpy7KVryk0dbF3YZGWR0=
Message-ID: <4807377b05080209417c7f5c40@mail.gmail.com>
Date: Tue, 2 Aug 2005 09:41:32 -0700
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Reply-To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc3] pci: restore BAR values after D3hot->D0 for devices that need it
In-Reply-To: <20050727141942.GB22686@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050708095104.A612@den.park.msu.ru>
	 <20050707.233530.85417983.davem@davemloft.net>
	 <20050708110358.A8491@jurassic.park.msu.ru>
	 <20050708.003333.28789082.davem@davemloft.net>
	 <20050708122043.A8779@jurassic.park.msu.ru>
	 <20050708183452.GB13445@tuxdriver.com>
	 <20050726234934.GA6584@kroah.com>
	 <20050727013601.GA13958@tuxdriver.com>
	 <20050727141202.GA22686@tuxdriver.com>
	 <20050727141942.GB22686@tuxdriver.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/05, John W. Linville <linville@tuxdriver.com> wrote:
> Some PCI devices (e.g. 3c905B, 3c556B) lose all configuration
> (including BARs) when transitioning from D3hot->D0.  This leaves such
> a device in an inaccessible state.  The patch below causes the BARs
> to be restored when enabling such a device, so that its driver will
> be able to access it.
> 

Is it just me or will this stuff help the kexec guys as well?  They seem 
to have lots of problems because drivers put the device into D3 before the 
reload of the new kernel.  I think this might help.

Jesse
