Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284942AbRLKJVd>; Tue, 11 Dec 2001 04:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284945AbRLKJVN>; Tue, 11 Dec 2001 04:21:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18742 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284942AbRLKJVC>; Tue, 11 Dec 2001 04:21:02 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rusty@rustcorp.com.au (Rusty Russell), anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5
In-Reply-To: <E16DEVr-0008SW-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Dec 2001 02:00:23 -0700
In-Reply-To: <E16DEVr-0008SW-00@the-village.bc.nu>
Message-ID: <m1ofl6uo60.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > 	If you number each CPU so its two IDs are smp_num_cpus()/2
> > 	apart, you will NOT need to put some crappy hack in the
> > 	scheduler to pack your CPUs correctly.
> 
> Which is a major change to the x86 tree and an invasive one. Right now the
> X86 is doing a 1:1 mapping, and I can offer Marcelo no proof that somewhere
> buried in the x86 arch code there isnt something that assumes this or mixes
> a logical and physical cpu id wrongly in error. 

Actually we don't do a 1:1 physical to logical mapping.  I currently
have a board that has physical id's of:  0:6 and logical id's of 0:1
with no changes to the current x86 code. 
> 
> At best you are exploiting an obscure quirk of the current scheduler that is
> quite likely to break the moment someone factors power management into the
> idling equation (turning cpus off and on is more expensive so if you idle
> a cpu you want to keep it the idle one for PM). Congratulations on your
> zen like mastery of the scheduler algorithm. Now tell me it wont change in
> that property.

The idea of a cpu priority for filling sounds like a nice one.  Even
if we don't use the cpu id bits for it.

Eric

