Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUHZCJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUHZCJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUHZCJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:09:04 -0400
Received: from ozlabs.org ([203.10.76.45]:39112 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266741AbUHZCIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:08:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16685.18011.723499.446490@cargo.ozlabs.ibm.com>
Date: Thu, 26 Aug 2004 12:09:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: anton@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 PPC64:  Another log buffer length patch.
In-Reply-To: <20040825200138.GN14002@austin.ibm.com>
References: <20040825200138.GN14002@austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> ===== arch/ppc64/kernel/ras.c 1.15 vs edited =====
> --- 1.15/arch/ppc64/kernel/ras.c	Mon Aug  2 03:00:41 2004
> +++ edited/arch/ppc64/kernel/ras.c	Wed Aug 25 14:46:33 2004
> @@ -108,6 +108,7 @@
>  
>  	ras_get_sensor_state_token = rtas_token("get-sensor-state");
>  	ras_check_exception_token = rtas_token("check-exception");
> +	rtas_get_error_log_max();

Why do we do this call, given that we don't use the result?  Is there
something time-critical about some future call, such that we want to
have fetched the value at this point?  If there is, it needs a comment
here, if not, let's remove this call.

Regards,
Paul.
