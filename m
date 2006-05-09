Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWEIQFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWEIQFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEIQFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:05:15 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45509 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751281AbWEIQFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:05:13 -0400
Date: Tue, 9 May 2006 09:05:28 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
Message-ID: <20060509160528.GA3168@w-mikek2.ibm.com>
References: <20060509070343.57853679F2@ozlabs.org> <44609A7B.7010103@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44609A7B.7010103@shadowen.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:34:51PM +0100, Andy Whitcroft wrote:
> 3) record the nid -- when we record the memory present in the system we
> are passed the nid.
> 
> Somehow the last of these seems the most logical given we have the
> correct information at the time we record that we need to instantiate
> the section.  So I had a quick go at something which seems to have come
> out pretty clean.  Attached is a completly untested patch to show what I
> am proposing.

Looks sane to me.  I've always wanted to encode the nid in the section.
But, never had a compelling reason to do so.

With this code in place, we could optimize the pfn_to_nid() routines to
now obtain the nid from the section (rather than page struct).  However,
I'm not sure this is worth the effort.

-- 
Mike
