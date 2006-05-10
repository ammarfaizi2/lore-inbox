Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWEJI0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWEJI0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWEJI0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:26:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30894 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932301AbWEJI0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:26:49 -0400
Date: Wed, 10 May 2006 09:26:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] BusLogic gcc 4.1 warning fixes
Message-ID: <20060510082645.GB18947@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Daniel Walker <dwalker@mvista.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200605100255.k4A2tuuf031655@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605100255.k4A2tuuf031655@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:55:56PM -0700, Daniel Walker wrote:
> I just commented out BusLogic_AbortCommand because the code that uses it is 
> commented out the same way .. It could just be removed .
> 
> Fixes the following warnings,
> 
> drivers/scsi/BusLogic.c: In function 'BusLogic_init':
> drivers/scsi/BusLogic.c:2302: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
> drivers/scsi/BusLogic.c: At top level:
> drivers/scsi/BusLogic.c:2963: warning: 'BusLogic_AbortCommand' defined but not used

this needs real error handling instead of just returning.  freeing resources
and so on.  similar for the other patches I guess.

