Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUI3Ggo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUI3Ggo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUI3Ggo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:36:44 -0400
Received: from ozlabs.org ([203.10.76.45]:56010 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268884AbUI3Ggm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:36:42 -0400
Date: Thu, 30 Sep 2004 16:35:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930063518.GD21889@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de> <20040930003846.GB25001@zax> <20040930055307.GA15291@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930055307.GA15291@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 07:53:07AM +0200, Olaf Hering wrote:
>  On Thu, Sep 30, David Gibson wrote:
> 
> > On Wed, Sep 29, 2004 at 09:47:30PM +0200, Olaf Hering wrote:
> > >  On Mon, Sep 13, David Gibson wrote:
> > > 
> > > > Andrew, please apply.  This patch has been tested both on SLB and
> > > > segment table machines.  This new approach is far from the final word
> > > > in VSID/context allocation, but it's a noticeable improvement on the
> > > > old method.
> > > 
> > > This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> > > Hangs after 'returning from prom_init', wants a power cycle.
> > 
> > Have you isolated the problem to the VSID allocation patch?  I think
> > there may have been a number of ppc64 changes which went into
> > 2.6.9-rc2-bk2.
> 
> Yes, rc2 does not boot on power3 with that patch.

Hrm.. current BK works on the 270 here, so it's not all power3s.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
