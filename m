Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290237AbSAOSSH>; Tue, 15 Jan 2002 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290232AbSAOSR6>; Tue, 15 Jan 2002 13:17:58 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:62453 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290233AbSAOSRj>; Tue, 15 Jan 2002 13:17:39 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Tue, 15 Jan 2002 10:17:29 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020115172413.GD7030@vitelus.com>
Message-ID: <Pine.LNX.4.40.0201151010560.24005-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CML2 is a tradeoff in the kernel config process. it (currently) trades
time for correctness. It has no effect after you have built the kernel.

I like this becouse there have been several times where I have had to go
on a scavanger hunt to figure out what option I need to turn on before I
can turn on another option (something that CML2 will fix)

as for the kbuild 2.5 performance 'penalty', is it really slower then
always doign make dep; make clean; make bzImage? Yes I know I don't always
have to do that, but I don't understand the rules as to when I do and when
I don't (they sound simple at first but there keep being exceptions
raised). having the new kernel build process always get this right is
valuble.

also the time penalties associated with these two options is something
that can (and will) be dealt with over time as they get optimized and
rewritten to be faster.

these are VERY different from the modules thing which is permanently
introducing additional penalties into the system that can affect it for
as long as it's running.

David Lang


 On Tue, 15 Jan 2002, Aaron Lehmann wrote:

> On Mon, Jan 14, 2002 at 10:50:20AM -0800, David Lang wrote:
> > I can see a couple reasons for building a kernel without useing modules.
>
> I agree with all of yours. IMHO, the proposed scheme for 2.5 is plain
> bad. It will require an initrd (initramfs, or whatever), and force
> kernel installation to be more difficult. The performance overhead
> sounds like a major downside, epsecially when currently people know
> what hardware they have and build things into the kernel accordingly.
>
> Between this and CML2, my mental image of 2.5+ is starting to look
> very grim.
>
