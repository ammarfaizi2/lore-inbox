Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWIMB1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWIMB1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWIMB1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:27:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:11751 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751423AbWIMB1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:27:42 -0400
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception 
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shaohua Li <shaohua.li@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
	 <1157573069.5713.24.camel@keithlap>
	 <1157594624.2782.45.camel@sli10-desk.sh.intel.com>
	 <200609070925.50145.bjorn.helgaas@hp.com>
	 <1157677028.2782.64.camel@sli10-desk.sh.intel.com>
	 <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Tue, 12 Sep 2006 18:27:39 -0700
Message-Id: <1158110859.6047.27.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 20:27 -0600, Bjorn Helgaas wrote:
> > On Thu, 2006-09-07 at 09:25 -0600, Bjorn Helgaas wrote:
> >> If we decide that "try HID first, then try CID" is the right thing,
> >> I think we should figure out how to make that work.  Maybe that
> >> means extending the driver model somehow.
> > Don't think it's easy, especially no other bus needs it I guess.
> 
> I agree it's probably not easy, but I think having the right
> semantics is more important than fitting cleanly into the
> driver model.  But I know that without code, I'm just venting
> hot air, not contributing to a solution.
> 
> How's the ACPI driver model integration going, anyway?  I seem
> to recall some patches a while back, but I don't think they're
> in the tree yet.
> 
> > Do we really need the memory hotplug device returns pnp0c01/pnp0c02?
> > What's the purpose?
> 
> I don't know.  But I think Keith already determined that a BIOS change
> is not likely.  I hate to ask for BIOS changes like this because it
> feels like asking them to avoid broken things in Linux.

  Ok my motherboard patch was dropped from -mm so I am broken again but
others are fixed. Is the answer that we do nothing about this issues?   

  I am pretty sure my SSDT table is valid if someone *cannot* point out
in the spec where my device is malformed  by having both HID and CID I
will not be able even start the request to change the BIOS (it would be
a waste of my time).  Sure having the CID of the memory device may be
overkill but is it wrong?  

  Unless someone can show me a alternate solution I am going to push the
check HID before CID patch to -mm in the next day or two. 

Thanks,
  Keith 



