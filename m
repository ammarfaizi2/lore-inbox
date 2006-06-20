Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWFTXIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWFTXIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWFTXIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:08:46 -0400
Received: from ns1.suse.de ([195.135.220.2]:50913 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751831AbWFTXIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:08:44 -0400
Date: Tue, 20 Jun 2006 16:05:33 -0700
From: Greg KH <gregkh@suse.de>
To: Brice Goglin <brice@myri.com>
Cc: Andi Kleen <ak@suse.de>, Dave Olson <olson@unixfolk.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060620230533.GB16598@suse.de>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de> <20060620212908.GA17012@suse.de> <44987661.5050907@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44987661.5050907@myri.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 06:27:45PM -0400, Brice Goglin wrote:
> Greg KH wrote:
> > No, I don't want a whitelist, as it will be hard to always keep adding
> > stuff to it (unless we can somehow figure out how to put a "cut-off"
> > date check in there).
> 
> My second patchset (Improve MSI detection v2) uses "PCI-E vs non-PCI-E"
> as a cut-off "date". After reading all what people said in this thread,
> I still think it is a good compromise (and very simple to implement) if
> we blacklist PCI-E and whitelist non-PCI-E chipsets.

No, that's not fair for those devices which do not have PCI-E and yet
have MSI (the original ones, that work just fine...)

Again, no "whitelist" please, just quirks to fix problems with ones that
we know we have problems with, just like all other PCI quirks...

thanks,

greg k-h
