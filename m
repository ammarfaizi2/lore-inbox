Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVAEPyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVAEPyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVAEPx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:53:28 -0500
Received: from vena.lwn.net ([206.168.112.25]:6555 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262470AbVAEPir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:38:47 -0500
Message-ID: <20050105153843.13414.qmail@lwn.net>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: remap_pfm_range() Linux-2.6.10 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 05 Jan 2005 10:00:24 EST."
             <Pine.LNX.4.61.0501050951520.13645@chaos.analogic.com> 
Date: Wed, 05 Jan 2005 08:38:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why wasn't PAGE_SHIFT put inside
> the new function? The base address cannot ever be used without
> PAGE_SHIFT.  In previous versions, information hiding was properly
> used to hide the implementation details. Now, part of the implementation
> detail is exposed to interface code.

Hmm... seems to me that the new interface *removes* the page shift one
used to have to apply to the offset found in the VMA; looks like an
improvement to me.

Incidentally, the change allows the remapping of areas with physical
addresses beyond the 32-bit range, which, I believe, was why it was
done.  Meanwhile, there's a nice compatibility function, so nobody's
driver broke.  To me, there doesn't seem to be much to complain about.

jon
