Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131963AbRCVK3J>; Thu, 22 Mar 2001 05:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRCVK3B>; Thu, 22 Mar 2001 05:29:01 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15113 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131963AbRCVK2u>; Thu, 22 Mar 2001 05:28:50 -0500
Date: Thu, 22 Mar 2001 06:24:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Patrick O'Rourke" <orourke@missioncriticallinux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <m18zly2pam.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0103220622390.21415-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2001, Eric W. Biederman wrote:

> Is there ever a case where killing init is the right thing to do? My
> impression is that if init is selected the whole machine dies. If you
> can kill init and still have a machine that mostly works, then I guess
> it makes some sense not to kill it.
>
> Guaranteeing not to select init can buy you piece of mind because
> init if properly setup can put the machine back together again, while
> not special casing init means something weird might happen and init
> would be selected.

When something weird happens, it might be better to kill
init and have the machine reset itself after the panic
(echo 30 > /proc/sys/kernel/panic).

Killing all other things and leaving just init intact
makes for a machine which is as good as dead, without a
chance for recovery-by-reboot...

OTOH, I haven't heard of the OOM killer ever chosing init,
not even of people who tried creating these special kinds
of situations to trigger it on purpose.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

