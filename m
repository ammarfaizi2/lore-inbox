Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUKCQCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUKCQCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKCQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:02:31 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:14734 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261663AbUKCQC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:02:28 -0500
Date: Wed, 3 Nov 2004 11:02:21 -0500
To: Jakob Oestergaard <jakob@unthought.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Message-ID: <20041103160221.GA15822@fieldses.org>
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <20041103151011.GC12752@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103151011.GC12752@unthought.net>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:10:11PM +0100, Jakob Oestergaard wrote:
> What I would like was for exportfs to either say "No! Fix your file
> stupid" or "Good! This setup will work reliably for all eternity then".
> 
> Is anyone considering fixing this?   And; is the problem mainly in
> exportfs, in the kernel, or both?  (relevant for me to know if I want to
> go fix it myself)

With recent kernels the kernel generally only queries userland for
export information on demand.  So if you want an error returned at
exportfs time, you need to modify exportfs.--b.
