Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUCSAWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbUCRXxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:53:53 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:64145 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263313AbUCRXh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:37:27 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Date: Thu, 18 Mar 2004 15:37:10 -0800
User-Agent: KMail/1.6.1
References: <1079651064.8149.158.camel@arrakis> <200403181523.10670.jbarnes@sgi.com> <8090000.1079652747@flay>
In-Reply-To: <8090000.1079652747@flay>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181537.10060.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 3:32 pm, Martin J. Bligh wrote:
> I think the closest answer we have is that it's a grouping of cpus and
> memory, where either may be NULL. 

Yep, that seems to make the most sense, but then part of me wants to
drop the term node and never use it again :)

> I/O isn't directly associated with a node, though it should fit into the 
> topo infrastructure, to give distances from io buses to nodes (for which 
> I think we currently use cpumasks, which is probably wrong in retrospect, 
> but then life is tough and flawed ;-))

It's probably not too late to change this to
pcibus_to_nodemask(pci_bus *), or pci_to_nodemask(pci_dev *), there
aren't that many callers, are there (my grep is still running)?

Thanks,
Jesse

