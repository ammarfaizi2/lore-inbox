Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289865AbSAWN41>; Wed, 23 Jan 2002 08:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289862AbSAWN4R>; Wed, 23 Jan 2002 08:56:17 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:5386 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289865AbSAWNz6>; Wed, 23 Jan 2002 08:55:58 -0500
Message-ID: <3C4EC0D8.1D8F391F@aitel.hist.no>
Date: Wed, 23 Jan 2002 14:55:36 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-dj2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Nekrasov <andy@spylog.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM killer.
In-Reply-To: <20020123125729.GA5542@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Nekrasov wrote:
> 
> Help.
> 
> Is it possible to disable VM-killer completely?
Obviously not - it triggers only when there isn't
enough memory to continue.  The alternative to a
OOM killer routine is either a kernel that locks up
effectively killing everything, or a kernel that
allocates all memory early requiring a _lot_ more
memory to run at all.  (If you had that memory
you wouldn't run out in the first place.)
> 
> Or make it not kill some critical tools. I want, for example, that
> in any situation sshd/nfsd/cron remained alive.

The trivial fix is to start sshd/nfsd/cron from /etc/inittab,
similiar to how getty usually starts.  They may still get
killed, but init will restart them asap.

Adding a lot of swap is also a good idea - the machine will
merely slow down instead of killing something.  

Helge Hafting
