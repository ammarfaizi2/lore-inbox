Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVAYPxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVAYPxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVAYPxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:53:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261968AbVAYPxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:53:03 -0500
Date: Tue, 25 Jan 2005 10:52:54 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Fruhwirth Clemens <clemens@endorphin.org>, <linux-kernel@vger.kernel.org>,
       Michal Ludvig <michal@logix.cz>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <20050124143109.75ff1ab8.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Andrew Morton wrote:

> These patches clash badly with Michael Ludvig's work:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/cryptoapi-prepare-for-processing-multiple-buffers-at.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
> 
> so someone's going to have to rework things.  Ordinarily Michael would go
> first due to test coverage.
> 
> James, your call please.  Also, please advise on the suitability of
> Michael's patches for a 2.6.11 merge.

I think the generic scatterwalk changes are more important and 
fundamental (still to be fully reviewed).

I agree with Fruhwirth that the cipher code is starting to become
ungainly.  I'm not sure these patches are heading in the right direction 
from a design point of view, although we do need the functionality.  

Perhaps temporarily drop the multible block changes above until we get the
generic scatterwalk code in and a cleaned up design to handle cipher mode
offload.

Fruhwirth, do you have any cycles to work on implementing your ideas for 
more cleanly reworking Michal's multiblock code?

Also, I would think this is more 2.6.12 material, at this stage.


- James
-- 
James Morris
<jmorris@redhat.com>


