Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUGATuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUGATuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUGATuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:50:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:58361 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266245AbUGATt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:49:59 -0400
Subject: Re: [PATCH] 2.6 PPC64: lockfix for rtas error log
	(third-times-a-charm?)]
From: Dave Hansen <haveblue@us.ibm.com>
To: linas@austin.ibm.com
Cc: paulus@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040701141931.E21634@forte.austin.ibm.com>
References: <20040701141931.E21634@forte.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1088711355.21679.152.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 12:49:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 12:19, linas@austin.ibm.com wrote:
> +	/* Log the error in the unlikely case that there was one. */
> +	if (unlikely(logit)) {
> +		buff_copy = kmalloc (RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
> +		memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
> +	}

You forgot to check the allocation for failure.

-- Dave

