Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVAGMoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVAGMoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVAGMoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:44:55 -0500
Received: from colin2.muc.de ([193.149.48.15]:20487 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261392AbVAGMox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:44:53 -0500
Date: 7 Jan 2005 13:44:53 +0100
Date: Fri, 7 Jan 2005 13:44:52 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: 256 apic id for amd64
Message-ID: <20050107124452.GB64665@muc.de>
References: <3174569B9743D511922F00A0C9431423072912EE@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C9431423072912EE@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:06:35PM -0800, YhLu wrote:
> Andi,
> 
> I made the Opteron using apic id from 16 later in LinuxBIOS.
> 
> So leave 0-15 for ioapic.
> 
> The problem is that the kernel (caliberate_delay) doesn't like that.
> 
> If using lpj=2170880 as the command line for that, it works well.
> 
> What's the jiffies? The TSC is changing but it doesn't.

jiffies is a counter of the timer interrupt. Most likely you broke
the timer somehow.

-Andi
