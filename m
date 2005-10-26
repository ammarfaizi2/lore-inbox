Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbVJZJbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVJZJbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVJZJbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:31:53 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:2511 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S932606AbVJZJbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:31:53 -0400
Subject: Re: [PATCH 1/5] Swap Migration V4: LRU operations
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20051025193028.6828.27929.sendpatchset@schroedinger.engr.sgi.com>
References: <20051025193023.6828.89649.sendpatchset@schroedinger.engr.sgi.com>
	 <20051025193028.6828.27929.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 11:31:23 +0200
Message-Id: <1130319083.17653.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 12:30 -0700, Christoph Lameter wrote:

> +		if (rc == -1) {  /* Not possible to isolate */
> +			list_del(&page->lru);
> +			list_add(&page->lru, src);
>  		}

Would the usage of list_move() not be simpler?

Peter Zijlstra

