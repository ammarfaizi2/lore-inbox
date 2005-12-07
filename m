Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVLGMfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVLGMfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVLGMfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:35:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750945AbVLGMfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:35:20 -0500
Date: Wed, 7 Dec 2005 12:35:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michal Feix <michal@feix.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] SCSI block devices larger then 2TB
Message-ID: <20051207123519.GA17414@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org
References: <4396B795.1000108@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396B795.1000108@feix.cz>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:21:09AM +0100, Michal Feix wrote:
> Greetings!
> 
> Current aic79xxx driver doesn't see SCSI devices larger, then 2TB. It 
> fails with READ CAPACITY(16) command. As far as I can understand, we 
> already have LBD support in kernel for some time now. So it's only the 
> drivers, that need to be fixed? LSI driver is the only one I found 
> working with devices over 2TB; I couldn't test any other driver, as I 
> don't have the hardware. Is it really so bad, that only LSI chipset and 
> maybe few others are capable of seeng such devices?

I definitly works fine with Qlogic parallel scsi and fibrechannel and emulex
fibre channel controllers aswell as lsi/engenio megaraid controllers.

It looks like aci79xx is just broken in that repsect. Unfortunately the
driver doesn't have a proper maintainer, we scsi developers put in fixes
and cleanups but we don't have the full documentation to fix such complicated
issue.  If you have a support contract with Adaptec complain to them.

