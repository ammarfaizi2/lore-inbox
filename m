Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVAIANz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVAIANz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 19:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVAIANy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 19:13:54 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:55457 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S262160AbVAIANH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 19:13:07 -0500
Message-ID: <41E07711.3040008@tlinx.org>
Date: Sat, 08 Jan 2005 16:13:05 -0800
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series 
References: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
In-Reply-To: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Horst von Brand wrote:

>"L. A. Walsh" <law@tlinx.org> said:
>  
>
>>I prefer to compile a kernel for
>>my specific machines, some of which are old and do better with a
>>hand-configured kernel rather than a Microsoftian monolith that
>>is compiled with all possible options as modules.
>>    
>>
>The generic kernel + modules is a nice convenience for those that don't
>compile their own. And the modules technology has made the need for
>custom-compiled kernels all but go away. It is a _huge_ step forward (yes,
>I do remember the large collection of Slackware boot disks for all sorts of
>weird setups).
>  
>
---
    It's a nice convenience for Microsoft as well.  That doesn't
mean I can run XP well on a machine with < 256Mb.  Linux, I can,
especially with a tuned kernel.  The binaries in the generic kernels
are still compiled for the pentium (586).  While my machines are old,
compiling for x686 can produce code that runs faster on x686 and above
machines.

>>I have one old laptop that sound just doesn't work on no matter
>>what the settings -- may be failed hardware, but darned if I can't
>>seem to easily stop the loading of sound related modules as hardware
>>is probed by automatic hardware probing on each bootup, and the loading
>>of sound modules by GUI dependencies on a memory constrained system.
>>    
>>
>
>Qualifies as "need for custom-compied kernel". Or even just custom
>configured GUI.
>  
>
---
    Yup...and easier to maintain such, with a vanilla, non-patched
kernel.

>>With each new kernel release, I wonder if it will be satisfactory
>>to use for a new, base-line, stable vanilla kernel, but post release
>>comments seem to prove otherwise. 
>>    
>>
    No one is expecting bug free, but there is a concept of
bug Severity and frequency of expected impact.  What I would like is
if there was a "stabilized released" intended to be free of major
destabilizing bugs.  It used to be that one wouldn't run the development
series on "work" machines -- ones used to do your everyday work.  There
was an acknowledged risk of using development kernels -- a risk that was
noticably greater than the previously defined "stable" series.  The
stable series were such that I would regularly upgrade my desktop and
server machines to the stable kernel while reserving the development kernel
to development and test machines.  This approached worked well for using
a forward moving stable version while leaving room to make larger and
riskier (greater potential for instability) changes in a development kernel.

    It seems that the eventual move to transition the development
kernel into a stable kernel took a great deal of time, effort and pain
which was spent on fixing and stabilizing all of the features to the point
that it would qualify as a "stable" kernel and even then, often, the first
couple to several point releases of a stable series were sketchy.  It
seems like this long stablization period (code freeze) was prolonged and
painful because attention wasn't given to stability and bug fixing,
sufficiently during the development process.

>Only TeX is guaranteed bug-free.
>
>  
>
>>It seems that some developers have the opinion that the end-user base
>>no longer is their problem or audience and that the distros will patch
>>all the little boo-boo's in each unstable 2.6 release.
>>    
>>
>
>AFAIU, the current development model is designed to _diminish_ the need of
>custom patching by distributions. 
>
     That hasn't seemed to happen -- and buying an off the shelf DVD/CD
pack that can't be used to upgrade nor have rescue capabilities for
the release from that DVD (neither SuSE 9.1's rescue DVD nor CD
could be used on a SuSE 9.1 installation with XFS).  If you can't boot
the system or are behind a firewall their pre-install patch process doesn't
have a place to enter a proxy address for patch downloading.

    But that's totally an aside.  Having a single unpatched kernel from
the kernel source/kernel.org is of great benefit (though one still has
to download the suse patches to upgrade their system).


>>Well, that's
>>just plain asking for problems.
>>    
>>
>Quite to the contrary.
>  
>
----
    Theory hasn't met up with reality or current practice.  In theory
the model you describe could work if many other things were perfect
in doing their part, but this is not the case.  Should != does.

>You could complain to the distribution maker (so every one of their users
>benefits from your problem, that is the whole point of open source!), undo
>the patch, run a vanilla kernel. No need to skip around (doing so is
>probably much more work than just changing kernels).
>  
>
     I have complained.  If you want a fix, it's like Microsoft -- they
don't release a fixed DVD -- if you are lucky, your fix may be rolled into
the following release, but with tons of additional features that can add
a host of new problems.  The turnaround time / vendor release is too
long.  If my machine can't be upgraded or a network card used to access
the internet has a new bug, I don't want to wait 3-6 months for another
$85-100+ release that is just as likely to have something else broken.
That's what I get with Microsoft.  I'd like the granularity of being
able to only replace my kernel from a stable kernel.org version that doesn't
have everything, including the kitchen sink compiled in.

>>                       I also wouldn't want to give up reporting
>>kernel bugs directly to developers as I would if I am using a non-vanilla,
>>or worse, some tainted module.
>>    
>>
>
>If it is a distribution kernel, you should complain to them, they will
>forward your complaint to the maintainers if it warrants doing so. Only if
>vanilla kernel you get to swamp the maintainers directly.
>  
>
    Swamp?  The bug is usually already fixed in the stable release since
the distro's release kernels, usually, at least a generation or two old.

>The people in charge decided otherwise, for sound reasons. If you don't
>like it, you are free to create you own fork off 2.6.10 (or something) and
>stabilize that. That is the wonder of open source...
>  
>
----
    People same the same about MS.  No one is stopping you from going 
off and
creating your own monolithic company to replace it.  But the same
factors that stop you from doing that stop a viable kernel fork -- can all
the people who work on the kernel be duplicated to work on a new
fork?  Otherwise a fork has about an ice-cube's chance in hell of
succeeding.  There are only so many open-source code designers/writers out
there.  It's not an infinite quantity that can be simply wished into
existance by someone's "blow off" comment about starting your own fork.

>Lots of rather pointless work. Much of it something each distribution has
>to do on their own (because f.ex. vanilla 2.4 is _just fixes_, no backports
>of cool (and required) new functionality), instead of cooperating in
>building a better overall kernel.
>  
>
---
    How long have you been selling commerical software like 
Microsoft's?  You have their attitude nailed.  "cool and new features" 
are always more sexy
than making sure it's sane and reliable.  That's what MS has done for 
ages --
it wasn't through "superior technology" that they one their market -- it was
through "perceptions", shaped by what was "cool" and "features".  Look at
the wide market for "skinning" various UI's.  How much of that helps
functionality or stability?  Eye candy is fine, but for serious work,
4 or more shell-windows are alot more friendly.

>Yep. That's why nobody (and that certainly includes you) is entitled to
>demand such.
>  
>
    Demand?  I *asked* about the idea of _reviving_ the stable series, 
explain why I think it is a good idea and/or problems with the current
situation and you take that as a demand?  Chill, dude!

>Andrew Morton had been designated for the job (and he accepted).
>  
>
    Very Cool.  Maybe he'd like spawn stable "stubblets" off the main
tree at appropriately stable times and work on an "extra-dot" of 
reliability.
One could think of the 4th number (2.6.10.x4th) as measurements of
cycles of reliability-only releases.  I admit, Linus has tried to do this
with the -preXX releases, but sometimes too many changes have gone into
a new dev release to easily assure things are stable -- and more 
importantly,
too many people are steering away from heavy use of the newer kernels
due to their increasingly higher chances of causing problems.

>>Nevertheless, it would be nice to see a no-new-features, stable series
>>spun off from these development kernels, maybe .4th number releases,
>>like 2.6.10 also becomes a 2.6.10.0 that starts a 2.6.10.1, then 2.6.10.2,
>>etc...with iteritive bug fixes to the same kernel and no new features
>>in such a branch, it might become stable enough for users to have confidence
>>installing them on their desktop or stable machines.
>>    
>>
>The 2.6.9-x kernels from Red Hat/Fedora are targeted to be
>exactly that...
>  
>
    So you agree, that kernel.org is no longer providing kernels stable
enough to use on desktop and server machines directly.  That's what I
am lamenting.  I don't like using pre-compiled kernels.  I prefer to
build them myself and know what goes into them and tailor them for
specific hardware so they are optimized for that hardware.  If I wanted
lower, generic performance, from pre-compiled binaries, I can get that
from Microsoft.  Hell, they'll even throw in a free Unix subsystem on
XP and above.  Of course it runs like a generic OS and I can't just download
the latest source and try out patches or compile my own custom version,
but that's what we expect from Microsoft.  You only get what is offered
by one (or more) vendors -- often only one that offers an imperfect solution
that can no longer be supported when the vendor closes up shop.

>>It wouldn't have to be months upon months of diverging code, as jumps
>>to a new stable base can be started upon any fairly stable development
>>kernel, say 2.6.10 w/e100 fixed, tracing fixed, the slab bug fix, and
>>the capabilities bugs fixed going into a 2.6.10.1 that has no new features
>>or old features removed.  Serious bug fixes after that could go into a
>>2.6.10.2, etc.  Such point releases would be easier to manage and only
>>be updated/maintained as long as someone was interested enough to do it.
>>    
>>
>That is exactly the model! Just that no vanillla 2.6.9.1 has been needed
>yet.
>  
>
---
    No?  Depends on who you ask.  A security bug was just published on
2.6.10.  There are some issues with some mainstream drivers and regressions
from 2.6.9.  You don't think an extra stability release with providing
only critical, severe or security bug fixes might not be appropriate?

>... conveniently forgetting that it is a experimental data point that
>people start using the kernel (and finding its bugs) only when it leaves
>"alpha" (by whatever name), so this doesn't work.
>  
>
    Forgetting nothing: having a 2.6.10.1, .2, .3 would show a commitment
to the development of a stable image that is meant to be usable "off
the shelf (kernel.org & mirrors)". 

    You can tit-for-tat my response, but it doesn't change my experience
with the current kernels.   Reality trumps theory but perceptions trump
reality.  I don't see the theory of how things "should" work has had
a significant effect on perceptions though they might be having a
beneficial effect in reality -- it just isn't manifesting enough to
change an increased perception of decreasing stability from the days of
having separate stable and development branches.  I was just suggesting
an alternate somewhere in the middle. 

If you have a better way of creating a stable series of kernels coming
off kernel.org, I'm not attached to any specific method of "how".

-l


