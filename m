Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135974AbRD0Pnc>; Fri, 27 Apr 2001 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136091AbRD0PnW>; Fri, 27 Apr 2001 11:43:22 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:45008 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135974AbRD0PnR>; Fri, 27 Apr 2001 11:43:17 -0400
From: Christoph Rohland <cr@sap.com>
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
	<3AE99CE8.BD325F52@antefacto.com>
Organisation: SAP LinuxLab
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
Date: 27 Apr 2001 17:38:19 +0200
Message-ID: <m3u23afj4k.fsf@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Padraig,

On Fri, 27 Apr 2001, Padraig Brady wrote:
> I don't have swap so don't need tmpfs, but could probably
> use it anyway without a backing store? 

Yes, it does not need backing store.

> Anyway why was ramfs created if tmpfs existed, unless tmpfs requires
> backing store?  They both seem to have been written around the same
> time?

- shm fs was written as a specialized fs to implement POSIX shared
  memory based on SYSV shm.
- ramfs was introduced shortly after shm fs and was meant as a
  programming example for a minimal virtual filesystem. 
- Later shm fs was redone to use the same methods like ramfs but still
  was only useable for shared memory.
- After the release of 2.4.0, I extended shm fs to support read/write
  and thus be tmpfs and since then it can replace ramfs.

Greetings
		Christoph


