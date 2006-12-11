Return-Path: <linux-kernel-owner+w=401wt.eu-S1750732AbWLKXZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWLKXZo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWLKXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:25:44 -0500
Received: from imf08aec.mail.bellsouth.net ([205.152.59.56]:34290 "EHLO
	imf08aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbWLKXZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:25:44 -0500
Message-ID: <457DB46C.4080009@bellsouth.net>
Date: Mon, 11 Dec 2006 13:41:32 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation behavior
References: <457C64C5.9030108@bellsouth.net> <20061210124907.60c4a0aa.pj@sgi.com> <20061210141435.afac089d.akpm@osdl.org> <Pine.LNX.4.64.0612110855380.500@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612110930180.500@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0612110930180.500@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Ahh. Fallback_alloc() does not do the check for GFP_WAIT as done in 
> cache_grow(). Thus interrupts are disabled when we call kmem_getpages() 
> which results in the failure.
> 
> Duplicate the handling of GFP_WAIT in cache_grow().
> 
> Jay could you try this patch?

The patch seems to fix the bug.  I've been running about an hour with it now, 
and I haven't seen any error messages.  Prior to the patch, I'd see the messages 
within a few minutes of starting a login session.

Jay
