Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUHHC5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUHHC5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUHHC5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:57:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265040AbUHHC5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:57:19 -0400
Date: Sat, 7 Aug 2004 22:57:08 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Rik van Riel <riel@redhat.com>
Subject: Re: SELINUX performance issues
In-Reply-To: <20040808002355.GA24690@krispykreme>
Message-ID: <Xine.LNX.4.44.0408072255580.27710-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Anton Blanchard wrote:

> The biggest problem is the global lock:
> 
> avc_has_perm_noaudit:
>         spin_lock_irqsave(&avc_lock, flags);
> 
> Any chance we can get rid of it? Maybe with RCU?

Yes, known problem.  I plan on trying RCU soon, Rik was looking at a 
seqlock approach.


- James
-- 
James Morris
<jmorris@redhat.com>


