Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVEEV5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVEEV5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVEEV5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:57:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19604 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261959AbVEEV5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:57:32 -0400
Date: Thu, 5 May 2005 16:57:25 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH [PPC64]: dead processes never reaped
Message-ID: <20050505215725.GJ11745@austin.ibm.com>
References: <20050418193833.GW15596@austin.ibm.com> <1113975850.5515.377.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113975850.5515.377.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 03:44:10PM +1000, Benjamin Herrenschmidt was heard to remark:
> On Mon, 2005-04-18 at 14:38 -0500, Linas Vepstas wrote:
> > 
> > The patch below appears to fix a problem where a number of dead processes
> > linger on the system.  On a highly loaded system, dozens of processes 
> > were found stuck in do_exit(), calling thier very last schedule(), and
> > then being lost forever.  

And this problem seems to be unreproducible.  Dang, it was one of the
more interesting ones I've seen.

--linas
