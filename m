Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755416AbWKNFQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbWKNFQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755417AbWKNFQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:16:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:13220 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1755416AbWKNFQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:16:42 -0500
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org,
       airlied@gmail.com, idr@us.ibm.com, paulus@samba.org
In-Reply-To: <20061113.210750.66175955.davem@davemloft.net>
References: <1163405790.4982.289.camel@localhost.localdomain>
	 <20061113.163138.98554015.davem@davemloft.net>
	 <1163469594.5940.42.camel@localhost.localdomain>
	 <20061113.210750.66175955.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 16:16:26 +1100
Message-Id: <1163481386.5940.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 21:07 -0800, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 14 Nov 2006 12:59:54 +1100
> 
> > If I "fix" the kernel to do the right thing, that is pass BAR values in
> > devices and expect BAR values in mmap, then I will break existing X
> > setups on machines where PCI is not mapped 1:1 (that is mostly CHRP
> > machines).
> > 
> > The problem I'm fixing in this patch is that while we were providing the
> > hacked up value in "devices", we were expecting the BAR value in mmap,
> > and there are apps expecting us to be consistent between the two, thus
> > the breakage.
> 
> Ok, I don't see much alternatives for you then.  I have no real
> objections to your patch.

Thanks. Fortunately, it's all going away soon :-)

Ben.


