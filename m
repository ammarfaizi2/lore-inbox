Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWG2Qbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWG2Qbs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWG2Qbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:31:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:43458 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932160AbWG2Qbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:31:46 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, kmannth@us.ibm.com
Subject: Re: [discuss] [Patch] 2/5 in support of hot-add memory x86_64 create arch_find_node
Date: Sat, 29 Jul 2006 18:25:15 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, andrew <akpm@osdl.org>,
       dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
References: <1154141545.5874.146.camel@keithlap>
In-Reply-To: <1154141545.5874.146.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291825.16308.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 04:52, keith mannthey wrote:
>   With the advent of the new ACPI hot-plug memory driver and mechanism
> is needed to deal with ACPI add memory events that do not contain the
> pxm (node) information. I do not believe that the add-event is required
> to contain this information so I create a arch_find_node generic layer
> used in the generic add_memory function.
>
>   If add_memory is called with node < 0 arch_find_node is invoked to
> fine the correct node to add the memory. This created the generic
> construct of arch_find_node.

It would be cleaner to always call add_memory from architecture specific
code instead of such ugly hooks

-Andi
