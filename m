Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTJHNih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTJHNiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:38:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261546AbTJHNdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:33:47 -0400
Date: Wed, 8 Oct 2003 14:33:38 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Maciej Zenczykowski <maze@cela.pl>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@osdl.org>, "Sharma, Arun" <arun.sharma@intel.com>,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-ID: <20031008133338.GH10906@parcelfarce.linux.theplanet.co.uk>
References: <571ACEFD467F7749BC50E0A98C17CDD8F3283D@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8F3283D@pdsmsx403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 07:42:23PM +0800, Tian, Kevin wrote:
> Thanks. :) Now I see... but are there any rules to decide which part
> should be upgraded even breaking the backward compatibility? You know,

Nothing should break.  Linux does not require userspace to be recompiled.
Binaries from the 0.99 days still run today.  An exception to this would
be ioctls that were introduced during the 2.5 cycle as they have not
appeared in a stable release yet.

Also, please remember that the size part of the ioctl is only a hint.
Very few things really care about it (which is why the breakage wasn't
discovered before).

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
