Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbULNH2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbULNH2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULNH2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:28:50 -0500
Received: from news.suse.de ([195.135.220.2]:54929 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261442AbULNH2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:28:41 -0500
Date: Tue, 14 Dec 2004 08:28:38 +0100
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: how to detect a 32 bit process on 64 bit kernel
Message-ID: <20041214072838.GJ1046@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20041212215110.GA11451@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212215110.GA11451@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 11:51:10PM +0200, Michael S. Tsirkin wrote:
> Hello!
> Is there a reliable way e.g. on x86-64 (or ia64, or any other
> 64-bit system), from the char device driver,
> to find out that I am running an operation in the context of a 32-bit
> task?
> 
> If no - would not it make a sence to add e.g. a flag in the
> task struct, to make it possible?

There are non portable ways, but they are strong discouraged because 
we aim to eventually support 32bit ABIs from 64bit processes too.
Don't do it.


-Andi
