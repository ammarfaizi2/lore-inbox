Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWCOWIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWCOWIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWCOWIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:08:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:60858
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750783AbWCOWIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:08:22 -0500
Date: Wed, 15 Mar 2006 14:08:12 -0800
From: Greg KH <gregkh@suse.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315220812.GA28485@suse.de>
References: <20060315193114.GA7465@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315193114.GA7465@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 02:31:14PM -0500, Vivek Goyal wrote:
> Hi,
> 
> Is there a reason why "start" and "end" field of "struct resource" are of
> type unsigned long. My understanding is that "struct resource" can be used
> to represent any system resource including physical memory. But unsigned
> long is not suffcient to represent memory more than 4GB on PAE systems. 

As Kumar has stated, people have tried to do this in the past.  Please
search the archives for the problems that will happen when you change
this.

I agree it should be fixed, but if you want to do this, you need to
audit a _lot_ of kernel code and fix it up everywhere.  Please start
with the old patches posted to lkml in the past and work from there.

good luck,

greg k-h
