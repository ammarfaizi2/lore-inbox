Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUGGRQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUGGRQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUGGRQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:16:11 -0400
Received: from fmr04.intel.com ([143.183.121.6]:29923 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265237AbUGGRQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:16:00 -0400
Date: Wed, 7 Jul 2004 10:13:25 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
Message-ID: <20040707101324.A30488@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <200407011215.59723.bjorn.helgaas@hp.com> <20040701115339.A4265@unix-os.sc.intel.com> <40EBED33.3050707@roma1.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EBED33.3050707@roma1.infn.it>; from davide.rossetti@roma1.infn.it on Wed, Jul 07, 2004 at 02:31:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:31:47PM +0200, Davide Rossetti wrote:
> Rajesh Shah wrote:
> 
> > What type of usage model did you have in mind to have the
> >
> >device write to memory instead of using MSI for interrupts?
> >  
> >
> for instance for a fast wake-up trick. the driver loops on a memory 
> location until the MSI write access changes the memory content...
> 
But you don't need to use MSI address/data pair for this. Devices 
can do "regular" memory writes to indicate command completion etc.
into driver allocated memory.

Rajesh
