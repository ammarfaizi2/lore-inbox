Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUFJAsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUFJAsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbUFJAsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:48:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266065AbUFJAsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:48:52 -0400
Date: Wed, 9 Jun 2004 21:49:33 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: cbjohns@mn.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd excessive CPU time
Message-ID: <20040610004933.GB6924@logos.cnet>
References: <6feb8721a0.721a06feb8@rdc-kc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6feb8721a0.721a06feb8@rdc-kc.rr.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 02:23:58PM -0500, cbjohns@mn.rr.com wrote:
> > Recent 2.4 VM should fix this, but you better of use 2.6.
> > 
> 
> Thanks Marcelo. Do you know of specific patches that have
> gone into 2.4 that might fix this? I may be able to just apply them
> rather than try a whole new kernel release.

The -aa VM merge during 2.4.23, most notable 2.4.23-pre4:

  o aa VM merge: Per-zone watermark changes, add lower_zone_reserve_ratio
  o aa VM merge: page reclaiming logic changes: Kills oom killer
  o aa VM merge: Page accounting helpers changes
  o aa VM merge: tunables
  o aa VM merge: Kill PF_MEMDIE
  o aa VM merge: Fixup page reclaiming changes patch

That plus a few merge mistakes fixed during later 2.4.23-pre.


