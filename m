Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbTEHLxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTEHLxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:53:06 -0400
Received: from rth.ninka.net ([216.101.162.244]:6630 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261383AbTEHLxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:53:04 -0400
Subject: Re: The magical mystical changing ethernet interface order
From: "David S. Miller" <davem@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, Russell King <rmk@arm.linux.org.uk>,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <3EB98878.5060607@us.ibm.com>
References: <20030507141458.B30005@flint.arm.linux.org.uk>
	 <20030507082416.0996c3df.rddunlap@osdl.org>
	 <20030507181410.A19615@flint.arm.linux.org.uk>
	 <20030507150414.1eaeae75.akpm@digeo.com>  <3EB98878.5060607@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052395526.23259.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 05:05:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 15:28, Dave Hansen wrote:
> The linker will order things in the final object in the order that you
> passed them.  We depend on this for getting __init functions run in the
> right order:

This is absolutely not guarenteed.  The linker is at liberty to
reorder objects in any order it so desires, for performance reasons
etc.

Any reliance on link ordering is broken and needs to be fixed.

-- 
David S. Miller <davem@redhat.com>
