Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316854AbSE3T4p>; Thu, 30 May 2002 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSE3T4o>; Thu, 30 May 2002 15:56:44 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40205
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316854AbSE3T4m>; Thu, 30 May 2002 15:56:42 -0400
Date: Thu, 30 May 2002 12:56:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Urban Widmark <urban@teststation.com>, linux-kernel@vger.kernel.org
Subject: Re: Processes stuck in D state with autofs + smbfs
Message-ID: <20020530195636.GC1136@matchmail.com>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Urban Widmark <urban@teststation.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205301421540.1921-100000@cola.enlightnet.local> <200205301417.g4UEH2Y32073@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 05:18:46PM -0200, Denis Vlasenko wrote:
> On 30 May 2002 10:36, Urban Widmark wrote:
> > > I also have this in my kernel log:
> > > May 26 06:33:16 fileserver kernel: Uhhuh. NMI received. Dazed and
> > > confused, but trying to continue May 26 06:33:16 fileserver kernel: You
> > > probably have a hardware problem with your RAM chips
> >
> > However, this error could (but I don't really know what the effects are of
> > this) potentially stop a process at some random point. If a process
> > crashes, for example an oops, while holding the semaphore that semaphore
> > will still be held and everyone trying to get in will stop in D state.
> 
> AFAIK this message says CPU got a spurious NMI. It does not kill the task,
> kernel logs this message and returns from NMI interrupt handler.
> 
> What does cat /proc/interrupts tell you?
>

What does this tell you?

           CPU0       CPU1       
  0:  106126905  106523397    IO-APIC-edge  timer
  1:       1290       1261    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          1    IO-APIC-edge  rtc
 16:  135638480  135641259   IO-APIC-level  eth0
 30:         12          8   IO-APIC-level  aic7xxx
 31:   16837019   16835973   IO-APIC-level  aic7xxx
NMI:          1          0 
LOC:  212643560  212643582 
ERR:          0
MIS:          0

> NMI may be truly spurious or a hardware failure indication. Give your box
> an overnight run of memtest86.

Yes, I planned to do that anyway, thanks.

Mike
