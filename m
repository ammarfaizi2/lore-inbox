Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWINX2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWINX2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWINX2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:28:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:41188 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932128AbWINX2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:28:20 -0400
Subject: Re: [ckrm-tech] [PATCH] BC:
	resource	beancounters	(v4)	(added	user	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158197232.20211.96.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
	 <1158081752.20211.12.camel@galaxy.corp.google.com>
	 <1158105732.4800.26.camel@linuxchandra>
	 <1158108203.20211.52.camel@galaxy.corp.google.com>
	 <1158109991.4800.43.camel@linuxchandra>
	 <1158111218.20211.69.camel@galaxy.corp.google.com>
	 <1158186247.18927.11.camel@linuxchandra>
	 <1158197232.20211.96.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 14 Sep 2006 16:28:15 -0700
Message-Id: <1158276495.6357.18.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 18:27 -0700, Rohit Seth wrote:

<snip>
> > > As said earlier, if strict QoS is desired then system should be
> > > appropriately partitioned so that the sum of limits doesn't exceed
> > > physical limit (that is cost of QoS).  Let us first get at least that
> > > much settled on and accepted in mainline before getting into these
> > > esoteric features.
> > > 
> > 
> > esoteric ?! Please look at the different operating system that provide
> > resource management and other resource management capability providers.
> > All of them have both guarantees and limits (they might call them
> > differently).
> > 
> 
> Is this among the very first features you would like (to get absolutely
> right) before containers get in mm tree?  Or is this something that can

Let me make it clear, I am interested in resource management and not in
containers.

IMO, for resource management to work as expected (as is in other OSes),
guarantee is needed. It will be a good idea to have it from start as it
would affect the design of controllers. 

For example, instead of writing two controllers (one to control limit
and another to provide guarantee), controller writers can provide both
in a single controller. (OpenVZ has two parameters, oomguarpages and
vmguarpages whose purpose is to provide some sort of guarantee using the
barrier and/or limit available in BC)
 
> wait after the minimal infrastructure is in Andrew's tree and the code
> gets wider testing...And above all we have agreed upon user interface.
> 
> -rohit
> 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


