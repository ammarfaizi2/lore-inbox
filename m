Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUEGKaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUEGKaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUEGKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 06:30:30 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:61449 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263457AbUEGKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 06:30:29 -0400
Date: Fri, 7 May 2004 12:24:06 +0200
From: DervishD <raul@pleyades.net>
To: linux-kernel@vger.kernel.org
Subject: Re: events kthread gone crazy
Message-ID: <20040507102406.GE11768@DervishD>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040506211934.GA1452@fargo> <20040506213450.GA11761@DervishD> <20040507091559.GA1166@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040507091559.GA1166@fargo>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

 * Davilín <david@pleyades.net> dixit:
> > > 11569 ?        SW<    0:00  \_ [events/0]
> > > 11570 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
> > > 11571 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
> > [Ad infinitum]
> >     It seems that ALSA is screwing something. Maybe you need to
> > recompile ALSA binaries or something like that :???
> I think i know the cause of the problem, i'll test it later. You had
> to be careful with 'install' directives in modprobe.conf to not cause
> circular dependencies, and i think maybe this is the problem. But this
> shouldn't trash the kernel with a lot of processes in D state that 
> cannot be killed...

    No, it shouldn't, obviously. Does not modprobe complain about the
circular dependency?
 
> >     Have you seen where xine is disk sleeping. It should not matter
> > to the sound problem, but...
> I was wrong, xine and aMule had nothing to do with the problem. Just a
> 'modprobe snd' triggers the problem.

    Oh, bad :(( Well, at least seems like you isolated the problem,
it shouldn't be hard to fix :?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
