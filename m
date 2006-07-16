Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWGPJoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWGPJoS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWGPJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:44:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:59663 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWGPJoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:44:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=iPGDvce5Xztdcv67jBROwAPQyLZP5vCsnMC1ZarBm2TThzVzurpFXuRDb55gWmsMxK89fzq4eh4zY1AK5ve6+2AiDxYjX+/9MHMqHfft7JkRwchv4D15gYrP4or+Tmgn4oYpl8FMafeFu/GCITSlLx5Q3SB8hyP8HfSJAKOJ1UI=
Date: Sun, 16 Jul 2006 11:44:31 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca>
cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Where is RLIMIT_RT_CPU?
In-Reply-To: <1153009392.6374.77.camel@idefix.homelinux.org>
Message-ID: <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
References: <1152663825.27958.5.camel@localhost>  <1152809039.8237.48.camel@mindpipe>
  <1152869952.6374.8.camel@idefix.homelinux.org> 
 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain> 
 <1152919240.6374.38.camel@idefix.homelinux.org>  <1152971896.16617.4.camel@mindpipe>
  <1152973159.6374.59.camel@idefix.homelinux.org>  <1152974578.3114.24.camel@laptopd505.fenrus.org>
  <1152975857.6374.65.camel@idefix.homelinux.org>  <1152978284.16617.7.camel@mindpipe>
 <1153009392.6374.77.camel@idefix.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jul 2006, Jean-Marc Valin wrote:

>> I don't think it's a problem.  If the admin does not want non-root users
>> to be able to lock up the machine, just don't put them in the realtime
>> group.
>
> What if the admin *wants* non-root users to have good quality audio, and
> just doesn't want them to crash the system (voluntarily and especially
> accidentally). Enforcing CPU limits *is* possible and it has already
> been done independently by both Ingo and Con. I'm just waiting for the
> feature to be available out-of-the box, which is not for today if kernel
> space keeps pointing at userspace and vice versa. :-(
>
> 	Jean-Marc
>

You can't have "random" users scheduling thing at real-time priorities.
A real-time system can only work if it is set up as whole and all 
real-time tasks are taken into consideration. If you allow a user to start 
another real-time task, that task might destroy the real-time properties 
of all the rest by taking too much cpu.

As I see it the only thing you can do is to use sudo to run anything,
which needs real-time priority, with higher priviliges, than what a normal 
user have. Then he can only start specific audio programs and can't crash 
the system (unless those programs have a bug).

Esben
