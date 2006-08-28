Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWH1JZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWH1JZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWH1JZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:25:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55726 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932417AbWH1JZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:25:09 -0400
Date: Mon, 28 Aug 2006 10:24:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write protect bit of Initio firmware
Message-ID: <20060828092429.GA8980@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de> <tkrat.94cecc462a778dde@s5r6.in-berlin.de> <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 01:17:31PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 27 Aug 2006, Stefan Richter wrote:
> >
> > Yet another mode pages related bug of Initio firmwares was seen.
> > INIC-1530 with a firmware by Initio responded with garbage to MODE SENSE
> > (10).  Some HDDs were therefore incorrectly marked as write protected:
> > http://bugzilla.kernel.org/show_bug.cgi?id=6947
> 
> Why does sbp2scsi_slave_configure() set "use_10_for_ms" in the first 
> place?

I suspect that's because the typical command set for ieee1394 devices is
RBC which only specifies the 10-byte commands.

