Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWIWAkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWIWAkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWIWAkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:40:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:33750 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964977AbWIWAkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:40:21 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: More thoughts on getting rid of ZONE_DMA
Date: Sat, 23 Sep 2006 02:37:44 +0200
User-Agent: KMail/1.9.3
Cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <200609230134.45355.ak@suse.de> <Pine.LNX.4.64.0609221724580.10484@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221724580.10484@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609230237.44132.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 02:25, Christoph Lameter wrote:
> Another solution may be to favor high adresses in the page allocator?

We used to do that, but it got changed because IO request merging without
IOMMU works much better if you start low and go up instead of the other
way round.

-Andi
