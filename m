Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWBTPNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWBTPNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWBTPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:13:37 -0500
Received: from ozlabs.org ([203.10.76.45]:20964 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030276AbWBTPNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:13:36 -0500
Date: Tue, 21 Feb 2006 02:09:53 +1100
From: Anton Blanchard <anton@samba.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 03/22] pHype specific stuff
Message-ID: <20060220150953.GB19895@krispykreme>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005709.13620.77409.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005709.13620.77409.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> +inline static u32 getLongBusyTimeSecs(int longBusyRetCode)
> +{
> +	switch (longBusyRetCode) {
> +	case H_LongBusyOrder1msec:
> +		return 1;
> +	case H_LongBusyOrder10msec:
> +		return 10;
> +	case H_LongBusyOrder100msec:
> +		return 100;
> +	case H_LongBusyOrder1sec:
> +		return 1000;
> +	case H_LongBusyOrder10sec:
> +		return 10000;
> +	case H_LongBusyOrder100sec:
> +		return 100000;
> +	default:
> +		return 1;
> +	}			/* eof switch */
> +}

Since this actually returns milliseconds it might be worth making it
obvious in the function name. Also no need to use studly caps for the
function name and variable. We will fix the studly caps H_LongBusy*
stuff another day :)

> +inline static long plpar_hcall_7arg_7ret(unsigned long opcode,
> +inline static long plpar_hcall_9arg_9ret(unsigned long opcode,

These belong in arch/powerpc/platforms/pseries/hvCall.S

Anton
