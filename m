Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTEJFHi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 01:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTEJFHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 01:07:38 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:34322 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263358AbTEJFHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 01:07:37 -0400
Date: Sat, 10 May 2003 06:20:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!)
Message-ID: <20030510062015.A21408@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	Francois Romieu <romieu@fr.zoreil.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20030510000222.A10796@electric-eye.fr.zoreil.com> <200305092339.h49NcYGi011242@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305092339.h49NcYGi011242@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Fri, May 09, 2003 at 07:38:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 07:38:34PM -0400, chas williams wrote:
> +
> +init_one_failure:
> +	if (atm_dev) atm_dev_deregister(atm_dev);
> +	if (he_dev) kfree(he_dev);
> +	pci_disable_device(pci_dev);
> +	return err;

kfree(NULL) if perfectly fine.  Also please untangle all this if
statements to two separate lines.

