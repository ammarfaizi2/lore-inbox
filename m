Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUGBVD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUGBVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUGBVD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:03:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:27268 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264929AbUGBVCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:02:34 -0400
Date: Fri, 2 Jul 2004 13:56:15 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: inuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] 2.6 RPAPHP structure size/performance
Message-ID: <20040702205615.GB29580@kroah.com>
References: <20040702112154.O21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702112154.O21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 11:21:54AM -0500, linas@austin.ibm.com wrote:
> 
> Hi Greg,
> 
> Please review and apply the following patch if you find it agreeable.
> 
> This patch does not make any functional changes, but does improve
> both performance and memory usage by rearranging structure elements.
> 
> The need for these changes became appearent during a code review of
> the disassembly involving this structure. The memory footprint of this
> structure is made smaller by grouping the byte fields next to each other.
> The access of the list_head can be simplified by making it the first element
> of the structure, thus avoiding a needless add-immediate without negatively
> impacting any of the other accesses.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>

Applied, thanks.

greg k-h
