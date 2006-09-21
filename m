Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWIULqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWIULqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWIULqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:46:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10936 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751104AbWIULqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:46:33 -0400
Date: Thu, 21 Sep 2006 12:46:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sumant Patro <sumantp@lsil.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org, akpm@osdl.org,
       hch@lst.de, linux-kernel@vger.kernel.org, Neela.Kolli@lsil.com,
       Bo.Yang@lsil.com
Subject: Re: [Patch 6/7] megaraid_sas: adds tasklet for cmd completion
Message-ID: <20060921114612.GB30858@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sumant Patro <sumantp@lsil.com>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, akpm@osdl.org, hch@lst.de,
	linux-kernel@vger.kernel.org, Neela.Kolli@lsil.com,
	Bo.Yang@lsil.com
References: <1158805889.4171.66.camel@dumbo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158805889.4171.66.camel@dumbo>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 07:31:29PM -0700, Sumant Patro wrote:
> This patch adds a tasklet for command completion.

Why would you need this?  The normal scsi command completion is offloaded
to the SCSI softirq ASAP so I don't see any point for those.  Do you see
too much time spent in completion of the internal commands?

