Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVGNNSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVGNNSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVGNNSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:18:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:46558 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261362AbVGNNSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:18:12 -0400
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Jul 2005 15:18:11 +0200
In-Reply-To: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel>
Message-ID: <p73hdex5xws.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> writes:

> This patch relaxes the direct i/o alignment check so that user addresses
> do not have to be a multiple of the device block size.

The original reason for this limit was that lots of drivers
(not only IDE) explode when you give them odd sizes. Sometimes
it is even worse.

I doubt all of them have been fixed.

Very risky change.

-Andi
