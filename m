Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbUKYCUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUKYCUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbUKYCUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:20:51 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:46964 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262924AbUKYCTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:19:49 -0500
Message-Id: <5.1.0.14.2.20041125131226.04507eb0@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Nov 2004 13:17:56 +1100
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning  
  and sickness
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <41A3BFAD.9000809@devicelogics.com>
References: <20041123222734.GK20608@wotan.suse.de>
 <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel>
 <419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel>
 <419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel>
 <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel>
 <5.1.0.14.2.20041123094109.04003720@171.71.163.14.suse.lists.linux.kernel>
 <41A2862A.2000602@devicelogics.com.suse.lists.linux.kernel>
 <p73k6sc1epi.fsf@bragg.suse.de>
 <41A3B23C.2080406@devicelogics.com>
 <20041123222734.GK20608@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:54 AM 24/11/2004, Jeff V. Merkey wrote:
[..]
>True. Without the proposed hardware change to the 1 GbE abd 10GbE adapter,
>I doubt this could be eliminated. There would still be the need to free 
>the descriptor
>from the ring buffer and this does require touching this memory. Scrap 
>that idea.
>The long term solution is for the card vendors to enable a batch mode for 
>submission
[..]

Jeff,

so the fact still remains: what is so bad about the current approach.
sure -- it can't do wire-rate 1GbE with minimal sized frames -- but even if 
it could -- would it be able to do bidirectional 1GbE with minimal sized 
frames?

even if you could, can you name a real-world application that would 
actually need that?


you make the point of "these things are necessary for 10GbE".
sure, but -- again -- 10GbE NICs are typically an entirely different beast, 
with far more offload, RAM , DMA & on-board firmware capabilities.

take a look at any of the 10GbE adapters, either already released, 
announced, or in development.  they all go well beyond 1GbE NICs for 
embedded smarts; they have to.

the ability to wire-rate minimum-packet-size 10GbE is still not going to be 
something that any real-world app (that i can think of) requires.
10GbE wire-rate is in the order of ~14.88 million packets/second.  that 
works out to approximately 1 packet every 67 nanoseconds.



cheers,

lincoln.

