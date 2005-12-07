Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbVLGFvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVLGFvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 00:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVLGFvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 00:51:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10125 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932644AbVLGFvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 00:51:25 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics 
In-reply-to: Your message of "Tue, 06 Dec 2005 14:52:33 -0800."
             <Pine.LNX.4.62.0512061447590.20377@schroedinger.engr.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Dec 2005 16:50:52 +1100
Message-ID: <9353.1133934652@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005 14:52:33 -0800 (PST), 
Christoph Lameter <clameter@engr.sgi.com> wrote:
>+DEFINE_PER_CPU(local_t [MAX_NUMNODES][NR_STAT_ITEMS], vm_stat_diff);

How big is that array going to get?  The total per cpu data area is
limited to 64K on IA64 and we already use at least 34K.

