Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278342AbRJMQMr>; Sat, 13 Oct 2001 12:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278344AbRJMQMh>; Sat, 13 Oct 2001 12:12:37 -0400
Received: from zero.aec.at ([195.3.98.22]:30738 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278342AbRJMQMU>;
	Sat, 13 Oct 2001 12:12:20 -0400
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, Ulrich Drepper <drepper@redhat.com>,
        Alex Larsson <alexl@redhat.com>, Padraig Brady <padraig@antefacto.com>,
        Andrew Pimlott <andrew@pimlott.ne.mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <oupitdx9n2m.fsf@pigdrop.muc.suse.de> <E15oq5j-00056Z-00@calista.inka.de> <20011013172419.B20499@kushida.jlokier.co.uk>
From: Andi Kleen <ak@muc.de>
Date: 13 Oct 2001 18:12:51 +0200
In-Reply-To: Jamie Lokier's message of "Sat, 13 Oct 2001 17:24:19 +0200"
Message-ID: <k2669jjz7g.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011013172419.B20499@kushida.jlokier.co.uk>,
Jamie Lokier <lk@tantalophile.demon.co.uk> writes:
> Andi Kleen says we can ignore the risk; I disagree, as there are some
> applications that cannot be trusted if the risk is plausible, and it can
> be fixed easily.

You're misquoting me badly.  I said we can ignore the risk that two
nanosecond resolution timestamps that get changed by two different cpus 
with out-of-sync cycle counter on a smp system and which are fast enough
to free/aquire the inode lock in a smaller time than they're out of sync
(= giving two file changes with the same ns timestamp) can be ignored.
I implied on the systems that don't have a cycle counter and which use
jiffie resolution gettimeofday it can be also ignored, because they're
unlikely to be SMP and dying out too anyways. 

-Andi


