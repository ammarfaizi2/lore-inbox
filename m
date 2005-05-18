Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVERNTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVERNTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVERNTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:19:55 -0400
Received: from one.firstfloor.org ([213.235.205.2]:41092 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261762AbVERNTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:19:36 -0400
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       shai@scalex86.org
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers
 for e1000
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
	<20050517190343.2e57fdd7.akpm@osdl.org>
	<Pine.LNX.4.62.0505171941340.21153@graphe.net>
	<20050517.195703.104034854.davem@davemloft.net>
	<Pine.LNX.4.62.0505172125210.22920@graphe.net>
From: Andi Kleen <ak@muc.de>
Date: Wed, 18 May 2005 15:19:34 +0200
In-Reply-To: <Pine.LNX.4.62.0505172125210.22920@graphe.net> (Christoph
 Lameter's message of "Tue, 17 May 2005 21:27:48 -0700 (PDT)")
Message-ID: <m1oeb86595.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> writes:

> On Tue, 17 May 2005, David S. Miller wrote:
>
>> > Because physically contiguous memory is usually better than virtually 
>> > contiguous memory? Any reason that physically contiguous memory will 
>> > break the driver?
>> 
>> The issue is whether size can end up being too large for
>> kmalloc() to satisfy, whereas vmalloc() would be able to
>> handle it.
>
> Oww.. We need a NUMA aware vmalloc for this?  

You can do that already by just changing process NUMA policy temporarily
while calling vmalloc.

-Andi
