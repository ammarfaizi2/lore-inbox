Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTIDH1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTIDH1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:27:11 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:18181 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264787AbTIDH0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:26:44 -0400
Date: Thu, 4 Sep 2003 08:26:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.6 patch] let "PCMCIA SCSI adapter support" menu depend on MODULES
Message-ID: <20030904082643.A26801@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030903232334.GL18025@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030903232334.GL18025@fs.tum.de>; from bunk@fs.tum.de on Thu, Sep 04, 2003 at 01:23:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:23:34AM +0200, Adrian Bunk wrote:
> When configuring a kernel without modules support "PCMCIA SCSI adapter 
> support" is a menu with no available items in it (all drivers depend on 
> "m").
> 
> The patch below only shows this menu when MODULES is enabled.

Not too happy with this watch although it's better than the previous
situation.  For one thing I'd get rid of the menu - we don't have menus
for PCI/ISA/MCA/whatever cards either.  Secondly these drivers probably
should work non-modular these days.

