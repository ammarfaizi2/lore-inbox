Return-Path: <linux-kernel-owner+w=401wt.eu-S1750948AbXACRA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXACRA4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbXACRA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:00:56 -0500
Received: from mga05.intel.com ([192.55.52.89]:13704 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750948AbXACRAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:00:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,233,1165219200"; 
   d="scan'208"; a="184136023:sNHT22000377"
Date: Wed, 3 Jan 2007 08:56:48 -0800
From: Mark Gross <mgross@linux.intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Cc: mark.gross@intel.com
Subject: Re: [PATCH] tlclk: fix platform_device_register_simple() error check
Message-ID: <20070103165648.GA3810@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20061122184111.GC2985@APFDCB5C> <20061127203452.GA12279@linux.intel.com> <20061128060830.GA28689@APFDCB5C> <20061129211757.GB5267@linux.intel.com> <20061202040332.GA22330@localhost.localdomain> <20061205182543.GA19497@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205182543.GA19497@linux.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:25:43AM -0800, Mark Gross wrote:
> On Sat, Dec 02, 2006 at 01:03:32PM +0900, Akinobu Mita wrote:
> > On Wed, Nov 29, 2006 at 01:17:57PM -0800, Mark Gross wrote:
> > > > We expect platform_device_register_simple() returns proper errno as pointer
> > > > when it fails.
> > > 
> > > What's wrong with EBUSY?
> > 
> > -ENOMEM or -EINVAL could be returned by platform_device_register_simple()
> > logically. And we don't know what kind of change will be made into driver
> > core in future.
> 
> Ok, would you like me to ack your earlier patch or will you send a new
> one?

I'm working on an update to the tlclk driver to avoid a race in the open
and read functions.  Do you have any changes I should roll into the
driver?

--mgross
