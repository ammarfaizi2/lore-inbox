Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVBJSWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVBJSWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBJSWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:22:05 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:2985 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262189AbVBJSWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:22:01 -0500
From: David Brownell <david-b@pacbell.net>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC PATCH] add wait_event_*_lock() functions
Date: Thu, 10 Feb 2005 10:21:58 -0800
User-Agent: KMail/1.7.1
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Al Borchers <alborchers@steinerpoint.com>
References: <20050210173948.GE2364@us.ibm.com>
In-Reply-To: <20050210173948.GE2364@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101021.58630.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 February 2005 9:39 am, Nishanth Aravamudan wrote:
> Hi David, LKML,
> 
> It came up on IRC that the wait_cond*() functions from
> usb/serial/gadget.c could be useful in other parts of the kernel. Does
> the following patch make sense towards this? 

I know that Al Borchers -- who wrote those -- did so with that
specific notion.  And it certainly makes sense to me, in
principle, that such primitives exist in the kernel ... maybe
with some tweaks first.  (And docs for all the wait_* calls?)

But nobody's pressed the issue before, to the relevant audience:
namely, LKML.  I'd be interested to hear what other folk think.
Clearly these particular primitives don't understand how to cope
with nested spinlocks, but those are worth avoiding anyway.

- Dave
