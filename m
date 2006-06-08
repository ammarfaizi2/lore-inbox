Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWFHJOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWFHJOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 05:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWFHJOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 05:14:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:21378 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751311AbWFHJOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 05:14:21 -0400
From: Andi Kleen <ak@suse.de>
To: bidulock@openss7.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Date: Thu, 8 Jun 2006 11:14:09 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606080907.26350.ak@suse.de> <20060608025930.A15559@openss7.org>
In-Reply-To: <20060608025930.A15559@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081114.09390.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> performance increased 2% per hyperthread; 

That would surprise me. Most likely you made some measurement error.

I guess it can be a difference if it's used in very hot loops, but then
i would expect a fallthrough path to win. Kernel code very rarely
has hot loops like this.

-Andi

