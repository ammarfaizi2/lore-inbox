Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbVKIUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbVKIUiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030774AbVKIUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:38:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:12186 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030649AbVKIUiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:38:51 -0500
Date: Wed, 9 Nov 2005 12:38:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Max Kellermann <max@duempel.org>
cc: rick@vanrein.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BadRAM for 2.6.14
In-Reply-To: <20051109095343.GA17048@roonstrasse.net>
Message-ID: <Pine.LNX.4.62.0511091236240.4509@schroedinger.engr.sgi.com>
References: <20051109095343.GA17048@roonstrasse.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Max Kellermann wrote:

> I have ported your BadRAM patch to the new kernel 2.6.14.  There were
> a few tiny formal corrections due to patch conflicts; besides that, I
> did not change anything.
> 
> To linux-kernel: is there a reason why this patch was never added to
> Linus' tree?  It helped me save money more than once.

We would like to do something similar but would include bad RAM removal 
while  the operating system is running. This may be because single bit ECC 
failures occur (which would cause the page to migrate away and mark the 
page as bad) or a hard ECC failure (references to the page are dropped if 
possible and the page is not dirty)
