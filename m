Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVARXbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVARXbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVARXbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:31:07 -0500
Received: from colin2.muc.de ([193.149.48.15]:38918 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261480AbVARXbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:31:05 -0500
Date: 19 Jan 2005 00:31:03 +0100
Date: Wed, 19 Jan 2005 00:31:03 +0100
From: Andi Kleen <ak@muc.de>
To: Brian King <brking@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, paulus@samba.org,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050118233103.GC66256@muc.de>
References: <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de> <1105626399.4664.7.camel@localhost.localdomain> <20050113180347.GB17600@muc.de> <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ED27CD.7010207@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:14:21AM -0600, Brian King wrote:
> Andi Kleen wrote:
> >As Brian said the device he was working with would just not answer,
> >leading to a bus abort.  This would get ffffffff on a PC.
> >You could simulate this if you want, although I think a EBUSY or EIO
> >is better.
> 
> Alan - are you satisfied with the most recent patch, or would you prefer 
> the patch not returning failure return codes and just bit bucketing 
> writes and returning all ff's on reads? Either way works for me.

Hmm, I think i haven't seen a recent patch. But as long as it doesn't
block in pci_config_* and is light weight there it's fine for me.

-Andi
