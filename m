Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266624AbUF3LiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUF3LiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUF3Lg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:36:28 -0400
Received: from ozlabs.org ([203.10.76.45]:4832 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266625AbUF3LgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:36:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.41869.78636.349800@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 21:27:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
In-Reply-To: <20040629175007.P21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> This patch moves the location of a lock in order to protect
> the contents of a buffer until it has been copied to its final
> destination. Prior to this, a race existed whereby the buffer
> could be filled even while it was being emptied.

Given that log_error() seems to be a no-op at the moment AFAICT, and
that Ben H was concerned about possible deadlocks if log_error
actually did do something, I'd like to see a resolution of (a) what
log_error should be doing and (b) whether there is in fact any
possibility of deadlock with this patch once (a) is resolved.

Thanks,
Paul.
