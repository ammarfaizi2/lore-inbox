Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUHIMbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUHIMbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUHIMbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:31:35 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:2628 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP id S266535AbUHIMbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:31:34 -0400
Date: Mon, 9 Aug 2004 14:31:26 +0200 (CEST)
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: ix86 Atomic ops during DMA...
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0408090809520.7612@chaos>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20040809123129.792F8507@etpmod.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Aug, Richard B. Johnson wrote:

How about:

	lock andl (%ebx),0xffffffff

Not sure 100% if I have the arguments in the right order ;-). 


> 	I need...
> 
> 	movl (%ebx), %eax	# Read status from register in ebx
> 	movl %eax, (%ebx)	# Write it back
> 
> ..to occur together without the bus being taken away by a DMA
>  operation until these two instructions are complete.

-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact/
