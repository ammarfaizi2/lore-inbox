Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVCDA1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVCDA1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVCDAHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:07:14 -0500
Received: from smtpout.mac.com ([17.250.248.86]:33499 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262748AbVCCXeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:34:24 -0500
In-Reply-To: <4737.10.10.10.24.1109878529.squirrel@linux1>
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303165533.GQ28536@shell0.pdx.osdl.net> <20050303170336.GL19505@suse.de> <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org> <4737.10.10.10.24.1109878529.squirrel@linux1>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C02F958C-8C3C-11D9-858B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 18:34:13 -0500
To: Sean <seanlkml@sympatico.ca>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 03, 2005, at 14:35, Sean wrote:
> Wait a second though, this tree will be branched from the development
> mainline.   So it will contain many patches that entered with less
> testing.   What will be the policy for dealing with regressions 
> relative
> to the previous $sucker release caused by huge patches that entered via
> the development tree?   Is reverting them prohibited because of the 
> patch
> size?

I can see two conflicting desires in this discussion, the desire to 
continue
development to avoid patch backlog, and the desire to slow down and 
stabilize
to provide a sane release-candidate and release scheme.  Could the two
desires somehow be both resolved simultaneously?

Perhaps instead of forking when 2.6.A is released, Linux could fork 
earlier,
after the 2.6.A-bk series.  After the fork, the main tree would become 
the
new 2.6.A+1-bk, and the forked tree would become 2.6.A+1-pre.  Then the 
final
stabilization and patches could continue while normal kernel development
moves on.  The latest kernel could take advantage of patches to the 
release
kernel, but would be able to maintain the steady patch stream.  The 
release
kernel could be managed by the previously mentioned "sucker", and could 
go
through a more-stabilizing and better tested Release Candidate series, 
and
then maintain post-release bugfixes.  When 2.6.A+1-pre is released, then
all upstream development on the forked 2.6.A-post tree would cease.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


