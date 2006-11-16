Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162157AbWKPCBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162157AbWKPCBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162160AbWKPCBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:01:37 -0500
Received: from dvhart.com ([64.146.134.43]:23964 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1162157AbWKPCBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:01:36 -0500
Message-ID: <455BC67F.6040708@mbligh.org>
Date: Wed, 15 Nov 2006 18:01:35 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost> <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com> <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com> <455B9825.3030403@mbligh.org> <Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Martin Bligh wrote:
> 
>> All we need is an appropriate zonelist for each node, pointing to
>> the memory it should be accessing.
> 
> But there is no memory on the node. Does the zonelist contain the zones of 
> the node without memory or not? We simply fall back each allocation to the 
> next node as if the node was overflowing?

Sure. there's no point in putting an empty zone in the zonelist.
We should just skip anything where present_pages is zero.

M.


