Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291125AbSBGFeN>; Thu, 7 Feb 2002 00:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291122AbSBGFdz>; Thu, 7 Feb 2002 00:33:55 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:15763 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291125AbSBGFdN>; Thu, 7 Feb 2002 00:33:13 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15458.4311.798427.298108@argo.ozlabs.ibm.com>
Date: Thu, 7 Feb 2002 16:29:59 +1100 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/network/ppp_generic.txt
In-Reply-To: <20020206.204153.67884178.davem@redhat.com>
In-Reply-To: <15457.63906.508722.290742@argo.ozlabs.ibm.com>
	<20020206.204153.67884178.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> How critical is this and the other PPP patches for 2.4.x?  Could it
> wait for 2.4.19-pre1?  I don't want to pressure Marcelo for 2.4.18
> final unless absolutely necessary.

Not critical at all.  I have forwarded Marcelo a patch which fixes one
of the problems in ppp_generic.c by changing all_ppp_lock into a
semaphore.  I agree that the rest of the fixes can wait for the
2.4.19-pre series.  The problems tend to show up mainly on SMP boxes
handling multiple PPP connections.  I posted the patch so that the
people who were having problems could try it and let me know if it
fixed their problems.

I would appreciate it though if you had time to look over the patch
and see if you think I have missed any potential races.

As for the documentation patch, it's not going to affect any code
behaviour, so it can go in whenever you and Marcelo think is
appropriate. :)

Paul.
