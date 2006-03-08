Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWCHQ0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWCHQ0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWCHQ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:26:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17796 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932331AbWCHQ0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:26:20 -0500
Date: Wed, 8 Mar 2006 08:26:09 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603080817500.5481@schroedinger.engr.sgi.com>
References: <31492.1141753245@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to explain the difference between the compiler reordering and the 
control of the compilers arrangement of loads and stores and the cpu 
reordering of stores and loads. Note that IA64 has a much more complete 
set of means to reorder stores and loads. i386 and x84_64 processors can 
only do limited reordering. So it may make sense to deal with general 
reordering and then explain i386 as a specific limited case.

See the "Intel Itanium Architecture Software Developer's Manual" 
(available from intels website). Look at Volume 1 section 2.6 
"Speculation" and 4.4 "Memory Access"

Also the specific barrier functions of various locking elements varies to 
some extend.
