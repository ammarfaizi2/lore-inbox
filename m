Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVCPOmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVCPOmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVCPOku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:40:50 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:38410 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262605AbVCPOiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:38:10 -0500
Date: Wed, 16 Mar 2005 09:37:45 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Rick Jones <rick.jones2@hp.com>
Cc: linux-kernel@vger.kernel.org, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, bonding-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.11] bonding: avoid tx balance for IGMP (alb/tlb mode)
Message-ID: <20050316143743.GC18393@tuxdriver.com>
Mail-Followup-To: Rick Jones <rick.jones2@hp.com>,
	linux-kernel@vger.kernel.org, ctindel@users.sourceforge.net,
	fubar@us.ibm.com, bonding-devel@lists.sourceforge.net,
	netdev@oss.sgi.com, jgarzik@pobox.com
References: <20050315215128.GA18262@tuxdriver.com> <4237833E.9080809@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4237833E.9080809@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 04:52:14PM -0800, Rick Jones wrote:
> Is that switch behaviour "normal" or "correct?"  I know next to nothing 

As Jay Vosburgh points-out, this patch only effects ALB and TLB modes.
These are modes where the link partner is unaware of the bonded
configuration.  In effect, we are tricking the switch into behaving
the way we desire.

Since the switch is unaware of our bonded behaviour, I think it makes
sense to accomodate this quirk related to IGMP snooping.

John
-- 
John W. Linville
linville@tuxdriver.com
