Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVHDKlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVHDKlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVHDKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:41:13 -0400
Received: from colin.muc.de ([193.149.48.1]:6412 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262459AbVHDKlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:41:11 -0400
Date: 4 Aug 2005 12:41:10 +0200
Date: Thu, 4 Aug 2005 12:41:10 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/8] x86_64:Dont call enforce_max_cpus when hotplug is enabled
Message-ID: <20050804104110.GB97893@muc.de>
References: <20050801202017.043754000@araj-em64t> <20050801203011.178499000@araj-em64t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203011.178499000@araj-em64t>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 01:20:20PM -0700, Ashok Raj wrote:
> No need to enforce_max_cpus when hotplug code is enabled. This
> nukes out cpu_present_map and cpu_possible_map making it impossible to add
> new cpus in the system.

Hmm - i think there was some reason for this early zeroing,
but I cannot remember it right now.

It might be related to some checks later that check max possible cpus.

So it would be still good to have some way to limit max possible cpus.
Maybe with a new option?

-Andi
