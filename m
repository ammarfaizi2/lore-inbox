Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUEMAon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUEMAon (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUEMAon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:44:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263731AbUEMAol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:44:41 -0400
Date: Wed, 12 May 2004 20:44:32 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <michal@logix.cz>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Pine.LNX.4.53.0405121707280.32352@maxipes.logix.cz>
Message-ID: <Xine.LNX.4.44.0405121947550.13491-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Michal Ludvig wrote:

> That's why I added .cia_ecb/.cia_cbc/... and modified cipher.c to call
> these whole-block-at-once methods instead of doing
> software-chaining+hardware-encryption. This way it's much much faster and
> I don't think that the changes to the cipher.c are somehow unclean.
> 
> Or can I achieve the same without extending the API?

No, the current API would not support this.

These kind of features are a subset of general hardware support (rather
than simple arch specific extensions like the s390 stuff), which I think
we need to take into account before making changes to the API.

Perhaps we should set up a list specifically to discuss & implement the 
hardware crypto API, as there seem to be several disparate efforts going 
on.


- James
-- 
James Morris
<jmorris@redhat.com>




