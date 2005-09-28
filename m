Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVI1NGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVI1NGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVI1NGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:06:12 -0400
Received: from fmr23.intel.com ([143.183.121.15]:56805 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750902AbVI1NGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:06:11 -0400
Date: Wed, 28 Sep 2005 06:06:03 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Bob Picco <bob.picco@hp.com>
Subject: Re: [PATCH 6/7] HPET-RTC: fix timer config register accesses
Message-ID: <20050928060603.B26313@unix-os.sc.intel.com>
References: <20050928071155.23025.43523.balrog@turing> <20050928071231.23025.2922.balrog@turing>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050928071231.23025.2922.balrog@turing>; from clemens@ladisch.de on Wed, Sep 28, 2005 at 09:12:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 09:12:31AM +0200, Clemens Ladisch wrote:
> Make sure that the RTC timer is in non-periodic mode; some stupid BIOS
> might have initialized it to periodic mode.
> 
> Furthermore, don't set the SETVAL bit in the config register.  This
> wouldn't have any effect unless the timer was in period mode (which it
> isn't), and then the actual timer frequency would be half that of the
> desired one because incrementing the comparator in the interrupt
> handler would be done after the hardware has already incremented it
> itself.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Ack on these two patches.
[PATCH 7/7] HPET-RTC: cache the comparator register
[PATCH 6/7] HPET-RTC: fix timer config register accesses

Andrew: Please apply.

Thanks,
Venki

