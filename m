Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUCMIld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 03:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUCMIld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 03:41:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:33497 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261981AbUCMIlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 03:41:32 -0500
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bryan Rittmeyer <bryan@staidm.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20040313074934.GA15019@staidm.org>
References: <20040313041547.GB11512@staidm.org>
	 <1079153403.2348.82.camel@gaston>  <20040313074934.GA15019@staidm.org>
Content-Type: text/plain
Message-Id: <1079166987.2348.88.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 19:36:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 18:49, Bryan Rittmeyer wrote:
> On Sat, Mar 13, 2004 at 03:50:03PM +1100, Benjamin Herrenschmidt wrote:
> > It would be wise to make the dcbz as long as possible in "advance"
> > before the actual write to the cache line.
> 
> I guess we could try "pre-dcbz" ala the dcbt prefetch code.
> Even dcbz right before stw is probably cheaper than RAM
> loading data that will be totally overwritten. It's hard to
> lose eliminating bus I/O (especially reads).

Except if the target is already in the cache... difficult choice.

> Any comments on the dcbt prefetch patch?

Didn't have time to look at it in details yet, maybe not before
monday or tuesday

Ben


