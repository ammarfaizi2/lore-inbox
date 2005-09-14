Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVINEKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVINEKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVINEKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:10:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:62127 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932584AbVINEKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:10:49 -0400
Date: Wed, 14 Sep 2005 06:10:46 +0200
From: Olaf Hering <olh@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Marcus Wegner <wegner3000@hotmail.com>
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-ID: <20050914041046.GA4512@suse.de>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509030245.12610.koch@esa.informatik.tu-darmstadt.de> <20050903223401.A7470@jurassic.park.msu.ru> <20050912174209.GA3965@suse.de> <20050913000733.A14261@jurassic.park.msu.ru> <20050913063053.GA24158@suse.de> <20050913154529.C15709@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050913154529.C15709@jurassic.park.msu.ru>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Sep 13, Ivan Kokshaysky wrote:

> On Tue, Sep 13, 2005 at 08:30:53AM +0200, Olaf Hering wrote:
> > The reporter has updated the bug.
> > 
> > https://bugzilla.novell.com/attachment.cgi?id=49717
> > https://bugzilla.novell.com/attachment.cgi?id=49715
> > https://bugzilla.novell.com/attachment.cgi?id=49716
> 
> Thanks, that helped.
> 
> The reason was that Acer BIOS left only _two_ bus numbers available
> for _three_ cardbus controllers, so pci_scan_bridge() assigns both
> numbers to the first controller and leaves two other ones uninitialized.
> 
> Please try the patch here, but note that you'll apparently have only
> one cardbus slot working. If you want more, use "pci=assign-busses"
> boot option.

Yes, this patch fixes the oops. The pci= option doesnt help.
