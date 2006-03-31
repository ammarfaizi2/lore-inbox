Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWCaAtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWCaAtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWCaAtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:49:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54728 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751078AbWCaAtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:49:32 -0500
Date: Thu, 30 Mar 2006 16:49:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Mosberger-Tang <David.Mosberger@acm.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <ed5aea430603301642t283174f6wa0587089920ca3a8@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603301645370.2068@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
 <ed5aea430603301642t283174f6wa0587089920ca3a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, David Mosberger-Tang wrote:

> I have to agree with Hans and I'd much prefer making the mode part of
> the operation's
> name and not a parameter.  Besides being The Right Thing, it saves a
> lot of typing.

IMHO It reduces the flexibility of the scheme and makes it not extendable. 
Leads to a large quantity of macros that are difficult to manage. 

Also some higher level functions may want to have the mode passed to them 
as parameters. See f.e. include/linux/buffer_head.h. Without the 
parameters you will have to maintain farms of definitions for all cases.



