Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTJASez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJASdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:33:55 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:58723 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261681AbTJASdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:33:41 -0400
Date: Wed, 1 Oct 2003 19:33:13 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
Subject: Re: Dave Jones: Fix cache size of Centrino CPU
Message-ID: <20031001183313.GB13115@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
References: <200310011805.h91I5L88013845@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310011805.h91I5L88013845@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 03:45:39PM +0000, Linux Kernel wrote:
 > ChangeSet 1.1136.2.9, 2003/10/01 12:45:39-03:00, marcelo@dmt.cyclades
 > 
 > 	  Dave Jones: Fix cache size of Centrino CPU
 > 
 > 
 > # This patch includes the following deltas:
 > #	           ChangeSet	1.1136.2.8 -> 1.1136.2.9
 > #	arch/i386/kernel/setup.c	1.73    -> 1.74   
 > #
 > 
 >  setup.c |    2 ++
 >  1 files changed, 2 insertions(+)
 > 
 > 
 > diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
 > --- a/arch/i386/kernel/setup.c	Wed Oct  1 11:05:23 2003
 > +++ b/arch/i386/kernel/setup.c	Wed Oct  1 11:05:23 2003
 > @@ -2291,6 +2291,8 @@
 >  	{ 0x83, LVL_2,      512 },
 >  	{ 0x84, LVL_2,      1024 },
 >  	{ 0x85, LVL_2,      2048 },
 > +	{ 0x86, LVL_2,      512 },
 > +	{ 0x87, LVL_2,      1024 },
 >  	{ 0x00, 0, 0}
 >  };
 >  
 > -

You seem to have dropped the first hunk of the diff.

		Dave


--- 1/arch/i386/kernel/setup.c~	2003-09-22 15:48:24.000000000 +0100
+++ 2/arch/i386/kernel/setup.c	2003-09-22 15:49:33.000000000 +0100
@@ -2296,6 +2296,8 @@
 	{ 0x23, LVL_3,      1024 },
 	{ 0x25, LVL_3,      2048 },
 	{ 0x29, LVL_3,      4096 },
+	{ 0x2c, LVL_1_DATA, 32 },
+	{ 0x30, LVL_1_INST, 32 },
 	{ 0x39, LVL_2,      128 },
 	{ 0x3b, LVL_2,      128 },
 	{ 0x3C, LVL_2,      256 },
 
 


-- 
 Dave Jones     http://www.codemonkey.org.uk
