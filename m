Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTIWTMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTIWTMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:12:08 -0400
Received: from home.kvack.org ([216.138.200.138]:65499 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S263429AbTIWTLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:11:41 -0400
Date: Tue, 23 Sep 2003 15:11:28 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923151128.B17437@kvack.org>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923191011.GA6460@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030923191011.GA6460@gtf.org>; from jgarzik@pobox.com on Tue, Sep 23, 2003 at 03:10:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 03:10:11PM -0400, Jeff Garzik wrote:
> Traditionally, if the NIC driver is accessing unaligned data, it should
> be using get/put_unaligned().

The driver isn't, the networking stack is (it has to).  For more examples 
where this behaviour is required: PPPoE, VLAN...

		-ben
-- 
"The software industry today survives only through an unstated agreement 
not to stir things up too much.  We must hope this lawsuit [by SCO] isn't 
the big stirring spoon." -- Ian Lance Taylor, Linux Journal, June 2003
