Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVCXA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVCXA6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVCXA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:58:17 -0500
Received: from smtpout.mac.com ([17.250.248.97]:62432 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262187AbVCXA6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:58:13 -0500
In-Reply-To: <20050323143405.502c1c84.akpm@osdl.org>
References: <20050323130628.3a230dec.akpm@osdl.org> <29204.1111608899@redhat.com> <30327.1111613194@redhat.com> <20050323143405.502c1c84.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5c0472408f4aec762f6f20d3b3dbd687@mac.com>
Content-Transfer-Encoding: 7bit
Cc: David Howells <dhowells@redhat.com>, mahalcro@us.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper()
Date: Wed, 23 Mar 2005 19:58:03 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 23, 2005, at 17:34, Andrew Morton wrote:
> Well one question is "does it make sense to make a keyring session a 
> part
> of the call_usermodehelper() API?".  As it appears that only one caller
> will ever want to do that then I'd say no, and that it should be some
> specialised thing private to the key code and the call_usermodehelper()
> implementation.
>
> So unless you think that a significant number of callers will appear 
> who
> are actually using the new capability then it would be better to keep 
> the
> existing call_usermodehelper() API.

I'm fairly sure that OpenAFS or other AFS clients will need to make use 
of
this when they move to the kernel keyring system.  I had a discussion 
with
Jeffrey Hutzelman on this topic a couple days ago on OpenAFS-Devel.  The
OpenAFS cache manager would want to call into userspace to convert 
between
Kerberos and AFS tickets/tokens.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


