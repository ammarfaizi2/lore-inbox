Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUDAWvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUDAWvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:51:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29366 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263301AbUDAWvO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:51:14 -0500
Subject: Re: [PATCH] mask ADT: replace cpumask_t implementation [3/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040401124628.2d017aeb.pj@sgi.com>
References: <20040329041256.0f27e8c4.pj@sgi.com>
	 <1080611340.6742.147.camel@arrakis> <20040401072232.798d98c8.pj@sgi.com>
	 <1080852024.9787.87.camel@arrakis>  <20040401124628.2d017aeb.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080859802.9787.90.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Apr 2004 14:50:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 12:46, Paul Jackson wrote:
> Matthew suggested:
> > Maybe we could #define it better on UP.  Something along the lines of:
> > #define cpu_online_map	({ cpumask_t up_cpu_map = { 1UL }; })
> 
> Yeah - I started playing with something like that too ...

Cool.  I think you're right about an actual cpumask_t for cpu_online_map
on UP not being a great idea, but I definitely think we can do better
than just #defining it to cpumask_of_cpu(0).

-Matt

