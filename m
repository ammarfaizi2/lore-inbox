Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTJHNih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTJHNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:38:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63971 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261567AbTJHNaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:30:20 -0400
Date: Wed, 8 Oct 2003 14:30:17 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       "Sharma, Arun" <arun.sharma@intel.com>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-ID: <20031008133017.GG10906@parcelfarce.linux.theplanet.co.uk>
References: <571ACEFD467F7749BC50E0A98C17CDD8F3283C@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8F3283C@pdsmsx403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 05:58:53PM +0800, Tian, Kevin wrote:
> Well, I may misunderstand the measurement here. By previous comment from
> Matthew Wilcox, I see "Clearly it's too late to change the ioctl
> definitions...". Er, so all things like IOR_BAD and size_t are just to
> keep current API untouched, while warning subsequent guys right way to
> populate ioctls. :) Then the last question is: is it worthy of some
> efforts to modify these APIs completely? Maybe the bee just bites
> once...

Already done on i386 and some other platforms.  Not on ia64 yet, I see.
The bad_ioctl stuff is part of that typechecking.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
