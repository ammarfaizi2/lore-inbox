Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWHPQa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWHPQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHPQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:30:54 -0400
Received: from ns.suse.de ([195.135.220.2]:17042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751149AbWHPQax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:30:53 -0400
Date: Wed, 16 Aug 2006 18:30:49 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [65/145] i386: Clean up code style in
 mpparse.c ACPI code
Message-Id: <20060816183049.33a92764.ak@suse.de>
In-Reply-To: <200608161208.44087.len.brown@intel.com>
References: <20060810 935.775038000@suse.de>
	<20060810193620.EBC8913B90@wotan.suse.de>
	<200608161208.44087.len.brown@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 12:08:43 -0400
Len Brown <len.brown@intel.com> wrote:

> On Thursday 10 August 2006 15:36, Andi Kleen wrote:
> > 
> > Remove some unlinuxy ways to write function parameter definitions.
> > Remove some stray "return;"s
> > 
> > No functional change.
> > 
> > Cc: len.brown@intel.com
> > Signed-off-by: Andi Kleen <ak@suse.de>
> > 
> > ---
> >  arch/i386/kernel/mpparse.c |   52 ++++++++++++++-------------------------------
> >  1 files changed, 17 insertions(+), 35 deletions(-)
> 
> Maybe it is time to just Lindent the file?
> When I Lindented the ACPI sub-system, I stopped short of mpparse.c.

I think except for the ACPI bits which I already fixed in this patch
everything else was linuxy already.

> 
> As you know, I'd like to see the ACPI part of mpparse.c split out into a different file
> that can be shared by i386 and x86_64.

I'm for splitting out in ACPI/non ACPI (with CONFIG for mpparse), but not for 
sharing.  I want the freedom to change mpparse's internal data structures without 
caring for i386.

The first step would be to get rid some of the hacks that convert ACPI into
mpparse.

-Andi
