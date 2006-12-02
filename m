Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162455AbWLBELR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162455AbWLBELR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162768AbWLBELR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:11:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:32644 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1162455AbWLBELP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:11:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VFigNLv5cxv3lf/lN7TZJXr2cznQtekHslTEfHhUaIlk0BM0JYdrw4KnB8jMkTiEBxQ5TQ7xWhfH+8+t/PRsvAIbGA83ogyg8rZ8uQ6wDlZFyrTd0Uadd4+B/lDlr3r+gKopno8+Sj/UnQqYqR6H9k/spP1sQ3PqEXumHyWq0fQ=
Date: Sat, 2 Dec 2006 13:03:32 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
       Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>, akpm@osdl.org
Subject: Re: [PATCH] tlclk: fix platform_device_register_simple() error check
Message-ID: <20061202040332.GA22330@localhost.localdomain>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org,
	Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>,
	akpm@osdl.org
References: <20061122184111.GC2985@APFDCB5C> <20061127203452.GA12279@linux.intel.com> <20061128060830.GA28689@APFDCB5C> <20061129211757.GB5267@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129211757.GB5267@linux.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 01:17:57PM -0800, Mark Gross wrote:
> > We expect platform_device_register_simple() returns proper errno as pointer
> > when it fails.
> 
> What's wrong with EBUSY?

-ENOMEM or -EINVAL could be returned by platform_device_register_simple()
logically. And we don't know what kind of change will be made into driver
core in future.
