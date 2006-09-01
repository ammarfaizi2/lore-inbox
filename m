Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWIAPiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWIAPiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWIAPiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:38:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27834 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751649AbWIAPiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:38:09 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157124580.21733.10.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122479.28577.64.camel@localhost.localdomain>
	 <1157124580.21733.10.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:37:54 -0700
Message-Id: <1157125074.28577.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 17:29 +0200, Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 07:54 -0700, Dave Hansen wrote:
> > Are all of the un/likely()s in here really needed?
> 
> Well, no un/likely is really needed. But they do help the compiler to
> generate better code. It IS unlikely that a page is discarded.

I know what they're _for_. ;)

I seem to recall people being poked in the past for sprinkling too many
of these things around their code.  I just wanted to make sure that
there was some tangible reason for doing it, other than speculative
performance optimization.

-- Dave

