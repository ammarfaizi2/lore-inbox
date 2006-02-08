Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030583AbWBHIui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030583AbWBHIui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWBHIui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:50:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:3307 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030583AbWBHIuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:50:37 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add execute_in_process_context() API
Date: Wed, 8 Feb 2006 09:50:11 +0100
User-Agent: KMail/1.8.2
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel> <p737j86l1es.fsf@verdi.suse.de> <20060208001833.49300fe1.akpm@osdl.org>
In-Reply-To: <20060208001833.49300fe1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080950.11606.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 09:18, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > James Bottomley <James.Bottomley@SteelEye.com> writes:
> > 
> > In general this seems like a lot of code for a simple problem.
> > It might be simpler to just put the work structure into the parent
> > object and do the workqueue unconditionally
> > 
> 
> That apparently would have really bad performance problems.  If we're
> !in_interrupt() we want to do the work synchronously.

It depends if it's common or not. If it's uncommon then simpler code
is better.


-Andi
