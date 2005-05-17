Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVEQQFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVEQQFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVEQQFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:05:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:53905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261777AbVEQPvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:51:07 -0400
Date: Tue, 17 May 2005 08:50:55 -0700
From: Greg KH <greg@kroah.com>
To: "Sy, Dely L" <dely.l.sy@intel.com>
Cc: Christoph Lameter <christoph@lameter.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       shai@scalex86.org
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-ID: <20050517155054.GA23640@kroah.com>
References: <468F3FDA28AA87429AD807992E22D07E054DA776@orsmsx408>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E054DA776@orsmsx408>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 08:38:45AM -0700, Sy, Dely L wrote:
> On Friday, May 13, 2005 3:36 PM, Greg KH wrote:
> > > The definition of GET_INDEX is suspect:
> > > 
> > > #define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) +
> b)
> > > 
> > > should this not be
> > > 
> > > #define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) +
> \
> > > 				((b) & 7))
> > > 
> > > ?
> >
> > Dely, any thoughts about this, or know who would know about it?
> 
> Greg,
> 
> I looked at the code and talked with Steve on this.  The fix is correct;
> i.e. b has to be masked with 7.  Would Christoph or you send out a 
> patch for the fix or would you like us to do so?  Thanks for finding out
> the problem.

If you would send me a patch (or someone), that I could apply, I would
appreciate it.

thanks,

greg k-h
