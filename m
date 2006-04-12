Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWDLRrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDLRrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDLRrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:47:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:22171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932277AbWDLRrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:47:10 -0400
From: Andi Kleen <ak@suse.de>
To: Oliver Weihe <o.weihe@deltacomputer.de>
Subject: Re: Opteron 128GB NODMAPSIZE too small?
Date: Wed, 12 Apr 2006 19:46:59 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <7986404.1144863211340.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
In-Reply-To: <7986404.1144863211340.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604121946.59895.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 April 2006 19:33, Oliver Weihe wrote:
> While running SuSE Linux 10.0 (x86_64) with a vanilla 2.6.16.1 on an
> 8way (8 sockets) Opteron equipped with 128GB (16GB per socket) of memory
> I found this in dmesg.
> 
> Any guesses to which value I should set NODEMAPSIZE?
> Currently it is 0xfff (from 'include/asm-x86_64/mmzone.h')

0x2fff. Or update to a newer kernel - it should
have that problem fixed by finding a better hash shift that works
with a smaller table too.

-Andi
