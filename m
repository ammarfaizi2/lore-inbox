Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbUKABGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUKABGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 20:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUKABGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 20:06:07 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:11737 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261714AbUKABF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 20:05:58 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
Date: Mon, 1 Nov 2004 12:05:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16773.35825.194304.830001@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid1 DM vs MD
In-Reply-To: message from Kianusch Sayah Karadji on Sunday October 31
References: <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 31, kianusch@sk-tech.net wrote:
> Hi!
> 
> After loosing some Data this week ... the question upon with technology to 
> use for Soft-RAID1 emerged the last days.
> 
> So which one is the recomended approach?
> 
> Should I use MD or DM?

I would say "md", but I am biased.

> 
> One benefit on using MD is that one can use it for root-devices without 
> initrd.
> 
> But where will the development go?

Forwards.
It is unlikely that support for useful functionality will go away.
I would prefer to see all arrays being assembled by an initrd-like
thing (initramfs??) but wouldn't dream of encouraging that until it
was easy to use and widely used.  We aren't there yet.

> 
> Will MD be supported in the future or will it be replaced by DM?

It is unlikely that md will be replaced by dm in the foreseeable
future.
It is possible that dm will increase in functionality and become very
widely used.

> 
> Will there be other raid levels supported in DM?
> 
> Which one has better Clean/Dirty recognition/detection?

While I know no details of DM, I doubt there is substantial difference
here.  It isn't a hard problem.

> 
> I had one MD-Raid1 where a good copy of the mirror was overwritten by the 
> bad (old) copy ... I lost 3 Month worth of data and I am expecting loosing 
> a linux project and in the worst case - even a court case :(

That sounds very unfortunate.  Without knowing the details it is hard
to comment on why this might have happened and how it could have been
avoided, but with modern tools (mdadm) and a sufficiently modern
kernel (2.4 at least) this should never be able to happen (without
deliberate carelessness on the part of the sysadmin).


> 
> Questions upon questions.
> 
> Sooner or later I'l migrate from SW-Raid to a HW-Raid-Controller ...

Many believe that that would not be a win.  Personally I share that
view.  HW-Raid-Controllers are not "open".  md (and dm) SW-Raid is.

Good Luck.

NeilBrown
