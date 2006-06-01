Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbWFAFnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbWFAFnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWFAFnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:43:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:3803 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751672AbWFAFni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:43:38 -0400
From: Neil Brown <neilb@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 1 Jun 2006 15:43:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17534.32383.326749.982364@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 006 of 10] md: Set/get state of array via sysfs
In-Reply-To: message from Chris Wright on Wednesday May 31
References: <20060601150955.27444.patches@notabene>
	<1060601051358.27613@suse.de>
	<20060601053356.GK2697@moss.sous-sol.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 31, chrisw@sous-sol.org wrote:
> * NeilBrown (neilb@suse.de) wrote:
> > 
> > This allows the state of an md/array to be directly controlled
> > via sysfs and adds the ability to stop and array without
> > tearing it down.
> > 
> > Array states/settings:
> > 
> >  clear
> >      No devices, no size, no level
> >      Equivalent to STOP_ARRAY ioctl
> 
> It looks like this demoted CAP_SYS_ADMIN to CAP_DAC_OVERRIDE for the
> equiv ioctl.  Intentional?

Uhm.. no.  Thanks.  I'll fix that, see if I've done similar things
elsewhere, and keep it in mind for the future.

NeilBrown
