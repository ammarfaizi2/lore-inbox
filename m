Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423028AbWCXEqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWCXEqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423018AbWCXEqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:46:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2176 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423007AbWCXEpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:45:33 -0500
Date: Thu, 23 Mar 2006 23:45:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Christoph Lameter <clameter@sgi.com>
cc: Stone Wang <pwstone@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced
 mlock-LRU semantic
In-Reply-To: <Pine.LNX.4.64.0603200923560.24138@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.63.0603232344190.23558@cuia.boston.redhat.com>
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
 <Pine.LNX.4.64.0603200923560.24138@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Christoph Lameter wrote:

> The result of not scanning mlocked pages will be that mmapped files will 
> not be updated unless either the process terminates or msync() is called.

That's ok.  Light swapping on a system with non-mlocked
mmapped pages has the same result, since we won't scan
mapped pages most of the time...

-- 
All Rights Reversed
