Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVCNSle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVCNSle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVCNSgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:36:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47337 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261680AbVCNSfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:35:44 -0500
Date: Mon, 14 Mar 2005 12:35:15 -0600
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: domen@coderock.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nacc@us.ibm.com
Subject: Re: [patch 01/14] char/snsc: reorder set_current_state() and
 add_wait_queue()
In-Reply-To: <200503140945.44323.jbarnes@engr.sgi.com>
Message-ID: <Pine.SGI.4.58.0503141226440.106301@gallifrey.americas.sgi.com>
References: <20050306223616.C82751EC90@trashy.coderock.org>
 <200503140945.44323.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Mar 2005, Jesse Barnes wrote:

> On Sunday, March 6, 2005 2:36 pm, domen@coderock.org wrote:
> > Any comments would be, as always, appreciated.
>
> I don't have a problem with this change, but the maintainer probably should
> have been Cc'd.  Greg, does this change look ok to you?  Note that it's
> already been committed to the upstream tree, so if it's a bad change we'll
> need to have the cset excluded or something.

I think it's safe enough.  Since interrupts are off at this point,
I don't think the order of the two functions actually matters (i.e.
we couldn't have received a signal until the call to
spin_unlock_irqrestore() anyway).

Thanks - Greg
