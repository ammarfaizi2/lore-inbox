Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVFZGy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVFZGy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 02:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVFZGy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 02:54:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6554 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261430AbVFZGyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 02:54:25 -0400
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] What is the significance of the "Out of IOMMU Space" error?
References: <a06230916bee3de9dd698@[129.98.90.227].suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Jun 2005 08:54:24 +0200
In-Reply-To: <a06230916bee3de9dd698@[129.98.90.227].suse.lists.linux.kernel>
Message-ID: <p73r7epwqu7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice Volaski <mvolaski@aecom.yu.edu> writes:
> 
> This error doesn't seem to be mentioned much in this space. Should it
> be taken at face value? Is it something simple like IOMMU should be
> set to a higher value in the HDAMA bios? A kernel bug? 

It could be the second, but normally it is the first. The defaults
supplied by the BIOS tend to be very tight and the 3ware controller
eats a lot of IOMMU space because it has deep queues.  I would just
increase the IOMMU space in the BIOS.

-Andi
