Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWCGUBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWCGUBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWCGUBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:01:38 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:58340 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751526AbWCGUBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:01:37 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 12:01:21 -0800
User-Agent: KMail/1.9.1
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <200603071134.52962.ak@suse.de> <1141759408.2617.9.camel@serpentine.pathscale.com> <200603071257.24234.ak@suse.de>
In-Reply-To: <200603071257.24234.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071201.22397.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 7, 2006 3:57 am, Andi Kleen wrote:
> On Tuesday 07 March 2006 20:23, Bryan O'Sullivan wrote:
> > On Tue, 2006-03-07 at 18:30 +0000, David Howells wrote:
> > > True, I suppose. I should make it clear that these accessor
> > > functions imply memory barriers, if indeed they do,
> >
> > They don't, but according to Documentation/DocBook/deviceiobook.tmpl
> > they are performed by the compiler in the order specified.
>
> I don't think that's correct. Probably the documentation should
> be fixed.

On ia64 I'm pretty sure it's true, and it seems like it should be in the 
general case too.  The compiler shouldn't reorder uncached memory 
accesses with volatile semantics...

Jesse
