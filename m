Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGaJBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGaJBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWGaJBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:01:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:60854 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932115AbWGaJBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:01:09 -0400
From: Andi Kleen <ak@suse.de>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [Patch] 3/5 in support of hot-add memory x86_64 =?iso-8859-1?q?arch=5Ffind=5Fnode=09x86=5F64?=
Date: Mon, 31 Jul 2006 10:57:44 +0200
User-Agent: KMail/1.9.3
Cc: kmannth@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       andrew <akpm@osdl.org>, discuss <discuss@x86-64.org>,
       dave hansen <haveblue@us.ibm.com>, konrad <darnok@us.ibm.com>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>
References: <1154141562.5874.147.camel@keithlap> <20060731171336.B86E.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060731171336.B86E.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311057.44383.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I know it is defined in x86-64. But I mean that SRAT is not
> arch dependent. It is defined by just ACPI.
> However, each arch which uses ACPI has a own code to parse SRAT table.
> Is it hard to merge all of them? Are there any special case?

Node setup is architecture specific and quite different between x86-64
and ia64. I guess one could factor out some common sanity code though, but I'm 
not sure it is worth it. Iirc ia64 doesn't do much sanity checking because
they assume the firmware was written by sane people; x86-64 doesn't have
that luxury.

-Andi
