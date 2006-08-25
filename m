Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422846AbWHYW7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWHYW7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWHYW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:59:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:61141 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422846AbWHYW7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:59:30 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Kirill Korotaev <dev@sw.ru>,
       rohitseth@google.com, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Kyle Moffett <mrmacman_g4@mac.com>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156546297.3007.273.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156417808.3007.78.camel@localhost.localdomain>
	 <1156463308.19702.40.camel@linuxchandra>
	 <FFE6D792-4D6C-4F19-A939-CBA5F0654FBA@mac.com>
	 <1156530108.1196.7.camel@linuxchandra>
	 <1156538777.3007.258.camel@localhost.localdomain>
	 <1156541845.1196.49.camel@linuxchandra>
	 <1156546297.3007.273.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Fri, 25 Aug 2006 15:59:26 -0700
Message-Id: <1156546766.1196.64.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 23:51 +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-25 am 14:37 -0700, ysgrifennodd Chandra Seetharaman:
> > 	/* resources statistics and settings */
> > 	struct ubparm		ub_parms[UB_RESOURCES];
> > };
> > 
> > ub_parms of _all_ controllers are held in this data structure.
> > 
> > So, keeping the beancounter data structure inside _a_ controller
> > specific data structure doesn't sound right to me, as other controllers
> > might also have the same need ?!
> > 
> > Controller _owns_ only ub_parms[controller_id], not the whole
> > user_beancounter, right ?
> 
> Right now I understand you
> 
> So you need
> 
> 	struct controller *ub_controller[UB_RESOURCES];
> 
> ?

exactly :)
> 
> Alan
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


