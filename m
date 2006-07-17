Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWGQPbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWGQPbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWGQPbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:31:32 -0400
Received: from colo.lackof.org ([198.49.126.79]:51387 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750841AbWGQPba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:31:30 -0400
Date: Mon, 17 Jul 2006 09:31:28 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Julien Cristau <julien.cristau@ens-lyon.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Linux v2.6.17 - PCI Bus hidden behind transparent bridge
Message-ID: <20060717153128.GA16679@colo.lackof.org>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <20060716193452.GA5299@bryan.is-a-geek.org> <20060717141315.GB2771@colo.lackof.org> <20060717142917.GJ5299@bryan.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717142917.GJ5299@bryan.is-a-geek.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 04:29:17PM +0200, Julien Cristau wrote:
> Loading the driver with modprobe doesn't change anything (it just
> outputs the 'Loaded prism54 driver' line), the device still doesn't
> appear in lspci or ifconfig -a.

Uhm, that's a different symptom than "doesn't work" :)
thanks for clarifying.

Sounds more like a problem with the Cardbus controller not providing
access to PCI config space, not telling PCI generic code there is a
PCI bus below it, or something like that.

Can you post "lspci -vvv -s 02:09" output for 2.6.17 as well?
I'd like to compare the CardBus bridge config info for both (2:09.0
and 02:09.1) controllers on both kernel releases.

thanks,
grant
