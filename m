Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbTC3Wk0>; Sun, 30 Mar 2003 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbTC3Wk0>; Sun, 30 Mar 2003 17:40:26 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:52753 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id <S261304AbTC3WkZ>;
	Sun, 30 Mar 2003 17:40:25 -0500
Message-ID: <3E8774FA.7070209@kn.vutbr.cz>
Date: Mon, 31 Mar 2003 00:51:38 +0200
From: Michal Schmidt <schmidt@kn.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reproducible terrible interactivity since 2.5.64bk2
References: <1048687681.6345.13.camel@spinel.tao.co.uk> <3E81945C.4010102@kn.vutbr.cz> <1048687681.6345.13.camel@spinel.tao.co.uk> <5.2.0.9.2.20030328181731.01997810@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030328181731.01997810@pop.gmx.net>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> Greetings potential victims :)
> 
> Care to see if the attached cures your woes?
> 
> This is a mixture of Ingo's last posted plus the scheduler tuning knobs 
> patch (/proc/sys/sched/*).  I added three new knobs to watch the effect 
> on different loads.  max_accel_slices limits the amount of sleep_time 
> you may add in one activation.  retard_prct_slices is a percentage of a 
> slice to deduct from sleep_time each activation (negative feedback for 
> heavy context switchers.. dang irman process_load).  force_switch is 
> there because I'm playing :)  I didn't do much to the scheduler itself, 
> only made it switch arrays in something closer to a square wave.  With 
> the settings as in the patch, and running a kernel build, top and irman, 
> irman reports worst case response times of 150ms for NULL load, 316ms 
> for memory_load, 414 for io_load, and 504ms for process_load.
> 
> Anyway, it's attached if you want to play with it ;-)
> 
>         -Mike
> 
> Oh, it's against virgin 2.5.66.


Thanks, running 2.5.66 with the patch applied I could no more reproduce 
the problem. I haven't tried playing with the knobs.

Michal

