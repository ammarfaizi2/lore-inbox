Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTENHcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTENHcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:32:17 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:31503 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id S262192AbTENHcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:32:16 -0400
Date: Wed, 14 May 2003 00:44:03 -0700
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030514074403.GA18152@bluemug.com>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
References: <200305130556_MC3-1-389D-DEBF@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305130556_MC3-1-389D-DEBF@compuserve.com>
X-PGP-Key: http://web.bluemug.com/~miket/OpenPGP/5C09BB33.asc
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:52:17AM -0400, Chuck Ebbert wrote:
> > cat >/sbin/swapoff
> > #!/bin/sh
> > /sbin/swapoff.real
> > /sbin/wipeswap
> > ^D
> > chmod +x /sbin/swapoff
> 
>   OK...
> 
>  # rpm --freshen mount-2.11n-12.rpm
> 
>    swapoff get silently replaced AFAICT.

Your arguments for swap wiping in the kernel aren't making sense.
It's the distribution that must be made secure, not just the kernel.
And a secure distribution wouldn't nuke its own version of swapoff.

Of course, as others have already noted, you really want encrypted
swap rather than swap wiping at shutdown time.

miket
