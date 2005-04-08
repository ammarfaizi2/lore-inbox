Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVDHBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVDHBIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVDHBIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 21:08:34 -0400
Received: from fmr22.intel.com ([143.183.121.14]:55238 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262641AbVDHBIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 21:08:24 -0400
Date: Thu, 7 Apr 2005 18:08:10 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050407180810.A10873@unix-os.sc.intel.com>
References: <20050405000524.592fc125.akpm@osdl.org> <42523F5D.7020201@yahoo.com.au> <20050405115113.A17809@unix-os.sc.intel.com> <42541830.1010201@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42541830.1010201@yahoo.com.au>; from nickpiggin@yahoo.com.au on Thu, Apr 07, 2005 at 03:11:12AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 03:11:12AM +1000, Nick Piggin wrote:
> Using the attached patch, a puny dual PIII-650 with ~400MB RAM swapped
> itself to death after 20000 infinite loop tasks had been pinned to one
> of the CPUs. See how you go.

Its goes well beyond the initial 7000 number I mentioned. Thanks.

One side-effect of this patch is: for example we have only two processes 
running on a cpu and both are pinned to that cpu. If someone comes and 
changes the affinity of one of these processes to all cpu's in the system, 
then it might take MAX_PINNED_INTERVAL before this process moves to an idle cpu.

thanks,
suresh
