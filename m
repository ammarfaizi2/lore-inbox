Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUDPSLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDPSLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:11:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263568AbUDPSHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:07:54 -0400
Date: Fri, 16 Apr 2004 19:07:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040416180750.GG24997@parcelfarce.linux.theplanet.co.uk>
References: <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <200404161803.i3GI3Lce011798@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404161803.i3GI3Lce011798@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 02:03:21PM -0400, Horst von Brand wrote:
> > Except that these "symlinks" are expected to follow the target upon
> > renames.  Which means that we either need a very messy scanning of
> > the entire tree on every rename (obviously not feasible) or we need
> > to store pointer to target and regenerate the path.  Which, in turn,
> > requires holding a reference.
> 
> Sounds an awful lot like ordinary hard links...

a) to directories?
b) userland really wants (relative) pathname here
c) still would require pinning the target down, so that doesn't simplify
anything.
