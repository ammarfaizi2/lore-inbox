Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSFTEsh>; Thu, 20 Jun 2002 00:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSFTEsg>; Thu, 20 Jun 2002 00:48:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10092 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318116AbSFTEsg>; Thu, 20 Jun 2002 00:48:36 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: marc.miller@amd.com, devnull@adc.idt.com, linux-kernel@vger.kernel.org
Subject: Re: >3G Memory support
References: <858788618A93D111B45900805F85267A062BB49D@caexmta3.amd.com>
	<20020620020809.GS22961@holomorphy.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Jun 2002 22:38:20 -0600
In-Reply-To: <20020620020809.GS22961@holomorphy.com>
Message-ID: <m18z5atvib.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Wed, Jun 19, 2002 at 07:01:08PM -0700, marc.miller@amd.com wrote:
> > Support of 4G of RAM is a configuration option when you compile the
> > kernel.  Is that setting turned on?  
> > I think it's in "General Options" when you do a "make menuconfig"
> > (I don't have a machine up at the moment that I can check).  There
> > are three options:  Less than 1G, 1G to less than 4G, and 4G or more.
> > That last option is the one you would want.  
> > If that's already enabled, hopefully one of the memory guys can pitch in...
> 
> This is actually yet another "32-bit virtualspace sucks" issue. You can't
> get at all your RAM from userspace because the virtualspace set aside for
> the kernel prevents you from using it to map physical memory. 64-bit
> virtualspace is too vast to be easily exhausted this way.

Note.  Getting at all of the memory isn't impossible but you have
to allocate a very large posix shared memory segment, and page it
in and out of your address space.

But the only easy solution to this problem is a 64bit machine.  At an
address bit consumed every year or so we have 2 or 3 decades before we
will need to move to 128bit machines to resolve this issue yet again.

At least the situation now is better than with ems.sys and xmm.sys and
their kin the last time x86 hit an address space wall.  Though we are
a little bit out from the point where all machines are configured with
more memory than they can practically use.

Eric
