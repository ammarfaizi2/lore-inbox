Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWGHAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWGHAXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGHAXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:23:23 -0400
Received: from ns.suse.de ([195.135.220.2]:52632 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932439AbWGHAXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:23:23 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 7/8] Single zone optimizations
Date: Sat, 8 Jul 2006 02:19:11 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com> <20060708000537.3829.77811.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000537.3829.77811.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080219.11049.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 02:05, Christoph Lameter wrote:
> Single Zone Optimizations
> 
> If we only have a single zone then various macros can be optimized.
> 
> We do not need to protect higher zones etc etc.

Nearly all the stuff you remove is slow path and even __init
where neither performance nor code size matter much.
The ifdefs look ugly. 

I have my doubts they are worth it.

-Andi


> 
