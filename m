Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275675AbTHOEH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 00:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275674AbTHOEH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 00:07:29 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:15629 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S275675AbTHOEH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 00:07:28 -0400
Date: Fri, 15 Aug 2003 14:07:11 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matt Mackall <mpm@selenic.com>
cc: davem@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
In-Reply-To: <20030815035056.GW325@waste.org>
Message-ID: <Mutt.LNX.4.44.0308151359260.26882-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, Matt Mackall wrote:

> This is back to turning off padding and getting at the raw hash
> transforms, and we were talking about doing this via flags. The
> FIPS-180-1 padding is done in sha1.c:digest which has no visibility to
> such flags.

One possibility is that we add a padding parameter to the dia_final 
method to indicate whether to perform padding.  This would be extracted 
from the tfm flags internally.

Also, a side note, please cc Ted on the hash folding discussions.


- James
-- 
James Morris
<jmorris@intercode.com.au>


