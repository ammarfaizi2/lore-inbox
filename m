Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUF3LiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUF3LiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUF3Lgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:36:33 -0400
Received: from ozlabs.org ([203.10.76.45]:4576 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266624AbUF3LgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:36:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.42236.698377.733729@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 21:33:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: (resend) Janitor signature of rtas_call() routine
In-Reply-To: <20040629154202.N21634@forte.austin.ibm.com>
References: <20040629154202.N21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> Can you please apply the following patch to the ameslab ppc64
> tree, and/or roll it upwards to the marclello 2.6 tree?
> This path is 100% pure cleanup; no functional changes.
> 
> I got irritated when I was given a -1 that was cast to an unsigned
> int that was then cast to a signed (64-bit) long, and so I received
> a value of 4 billion instead of -1.  This patch fixes this insanity.
> 
> Different files were treating this return code as being signed
> or unsigned, 32-bit or 64-bit.  The 'real' return code is always
> a signed 32-bit quantity, so this patch just makes the usage
> consistent across the board.

I beat you to the punch on this one, I'm afraid. :)  I changed
rtas_call to return an int in the prom cleanup patch I sent to Andrew
last week.  You did spot a few places that I missed though, so I'll
send Andrew a patch to fix those up shortly.

Regards,
Paul.


