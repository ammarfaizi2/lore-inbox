Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVCaB16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVCaB16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVCaB16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:27:58 -0500
Received: from smtpout.mac.com ([17.250.248.71]:7167 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262497AbVCaB14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:27:56 -0500
In-Reply-To: <424B4E75.4010107@yahoo.com.au>
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org> <424AFA98.9080402@grupopie.com> <aae129062f1e3992c8ec025d5f239be9@mac.com> <20050330233825.GS17420@devserv.devel.redhat.com> <e8fc51864bab0a24b04af9867d748f5f@mac.com> <424B4E75.4010107@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <68347a035b081a18796b4b3cbcea0df7@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Paulo Marques <pmarques@grupopie.com>, akpm@osdl.org,
       Jakub Jelinek <jakub@redhat.com>,
       Shankar Unni <shankarunni@netscape.net>, linux-kernel@vger.kernel.org,
       bunk@stusta.de, khali@linux-fr.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Not a GCC bug (was Re: Big GCC bug!!! [Was: Re: Do not misuse Coverity please])
Date: Wed, 30 Mar 2005 20:27:34 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 30, 2005, at 20:12, Nick Piggin wrote:
> Why should this be in the kernel makefiles? If my_struct is NULL,
> then the kernel will never reach the if statement.

Well, I think there is probably some arch code that uses 16-bit
that might use a null pointer, or at least a struct that starts
at the 0 address, which would have problems.  I think it would
be better to avoid that issue just in case, especially since
this optimization does not save anything in the case of properly
written code.

> A warning might be nice though.

If we could turn off the optimization and add a warning, I
would support that.  Even if we could only add the warning, then
at least people would know.


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


