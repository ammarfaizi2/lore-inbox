Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTEGWRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTEGWRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:17:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47602 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264305AbTEGWRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:17:01 -0400
Message-ID: <3EB98878.5060607@us.ibm.com>
Date: Wed, 07 May 2003 15:28:08 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Russell King <rmk@arm.linux.org.uk>, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
References: <20030507141458.B30005@flint.arm.linux.org.uk>	<20030507082416.0996c3df.rddunlap@osdl.org>	<20030507181410.A19615@flint.arm.linux.org.uk> <20030507150414.1eaeae75.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
>>A wild stab in the dark, I'd think maybe the init ordering changed:
> 
> Well stabbed.  The relative ordering of tulip and ne2k in
> drivers/net/Makefile got changed.
> 
> Maybe we should reorganise the 2.5 Makefile to copy the 2.4 Makefile's
> ordering.  How pleasant.
> 
> I suspect the linker is at liberty to reorder these anyway.

The linker will order things in the final object in the order that you
passed them.  We depend on this for getting __init functions run in the
right order:
http://groups.google.com/groups?selm=linux.kernel.27361.1016068035%40kao2.melbourne.sgi.com

-- 
Dave Hansen
haveblue@us.ibm.com

