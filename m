Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTBSVTx>; Wed, 19 Feb 2003 16:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbTBSVTx>; Wed, 19 Feb 2003 16:19:53 -0500
Received: from havoc.daloft.com ([64.213.145.173]:1159 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261742AbTBSVTw>;
	Wed, 19 Feb 2003 16:19:52 -0500
Date: Wed, 19 Feb 2003 16:29:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Tom Lendacky <toml@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] IPSec protocol application order
Message-ID: <20030219212950.GC4977@gtf.org>
References: <1045687340.3419.14.camel@tomlt2.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045687340.3419.14.camel@tomlt2.austin.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 02:42:19PM -0600, Tom Lendacky wrote:
> The IPSec RFC (2401) and IPComp RFC (3173) specify the order in which
> the COMP, ESP and AH protocols must be applied when being applied in
> transport mode.  Specifically, COMP must be applied first, then ESP
> and then AH.  Also, transport mode protocols must be applied before
> tunnel mode protocols.
> 
> Here is a patch that creates the xfrm_tmpl structures in the order
> required by the RFCs.  The patch requires that the application order
> of new transformations/protocols be specified for transport mode
> in order to have an xfrm_tmpl structure created.  If this is not
> desired, an additional transport mode loop can be placed ahead of the
> COMP/ESP/AH transport mode loops that creates xfrm_tmpl structures
> for protocols other than COMP/ESP/AH.

hmmm... do you really need to duplicate all that code, just to define
the order?


