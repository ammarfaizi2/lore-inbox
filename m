Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269867AbUIDKLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269867AbUIDKLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIDKLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:11:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:1542 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267597AbUIDKLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:11:34 -0400
Date: Sat, 4 Sep 2004 11:11:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
Message-ID: <20040904111131.A13593@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409041053450.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409041053450.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 11:02:38AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define __OS_HAS_AGP (defined(CONFIG_AGP) || defined(CONFIG_AGP_MODULE))

This should be something like

#define __OS_HAS_AGP \
	(defined(CONFIG_AGP) || \
	 (defined(CONFIG_AGP_MODULE) && defined(MODULE)))

else it's okay to me.
