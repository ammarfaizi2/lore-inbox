Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVIFUyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVIFUyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVIFUyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:54:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11212 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750908AbVIFUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:54:30 -0400
Date: Tue, 6 Sep 2005 21:54:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [patch 2.6.13 2/2] 3c59x: add option for using memory-mapped PCI I/O resources
Message-ID: <20050906205429.GA19319@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
	jgarzik@pobox.com
References: <20050906204147.GC20145@tuxdriver.com> <20050906204400.GD20145@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906204400.GD20145@tuxdriver.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 04:44:00PM -0400, John W. Linville wrote:
> Add module option to enable 3c59x driver to use memory-mapped PCI I/O
> resources.  This may improve performance for those devices so equipped.
> 
> Add "use_mmio=1" to the 3c59x module options in order to enable this
> functionality.

I'm not sure a module option makes sense for this setting, except maybe
as a debugging aid.  You should rather have a flag in the PCI IDs private
data that can be used to enable mmio for those cards that support it.

