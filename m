Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTKSTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 14:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTKSTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 14:47:25 -0500
Received: from ns.media-solutions.ie ([212.67.195.98]:35340 "EHLO
	mx.media-solutions.ie") by vger.kernel.org with ESMTP
	id S264045AbTKSTrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 14:47:05 -0500
Message-ID: <3FBBC849.5060608@media-solutions.ie>
Date: Wed, 19 Nov 2003 13:45:13 -0600
From: Keith Whyte <keith@media-solutions.ie>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: es-mx, es-es, en, en-us
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 fork & defunct child => system is hacked
References: <1069053524.3fb87654286b5@ssl.buz.org> <3FB8E40F.EF61CA7@gmx.de> <3FB96718.20103@media-solutions.ie> <20031118103907.GA23644@iapetus.localdomain>
In-Reply-To: <20031118103907.GA23644@iapetus.localdomain>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RelayImmunity: 212.67.195.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:

>On Mon, Nov 17, 2003 at 06:26:00PM -0600, Keith Whyte wrote:
>  
>
>>{ strace listing deleted, see 
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=106905386725308&w=2 }
>>    
>>
>
>First of all, /bin/true doing a fork() basically means you've
>been hacked: there should not be any such code in there. The
>open("/proc/17904///////////exe" is anouther piece of clear evidence
>that your system has been hacked.
>
>Why the additional slashes?
>

Is it at all possible that this behaviour is due to strace?
I have just installed under a fresh directory, from the slackware 
packages, the glibc-so libs, a few progs, strace, and chroot'ed into 
that system.
 I still get the same behaviour. So does that mean it _has_ to be the 
kernel that is at fault?

a cmp on the distro kernel and the one on my system does show this..:

cmp -b -l /boot/vmlinuz /home/r2/boot/vmlinuz
    499   1 ^A     0 ^@

but that is the rootflags, no? I must have set it ro before.

 
I am going to compile a kernel on a clean machine and boot the machine 
with that as soon as i can get somebody down there to monitor it in case 
it doesn't come back up with the new kernel.

>I suspect a library/or LD_PRELOAD hack which simply encodes the getpid()
>return value in decimal notation and stores it right into a static
>buffer containing
>
>	"/proc//////////////////exe"
>
>because it can't use sprintf at that point for some reason (maybe
>just because it is a library/LD_PRELOAD hack).
>
>
>  
>
I think I vaguely know what your saying here, but why? why would it have 
happened as soon as the machine was first brought up.. (after the 
initial install), then agian after a reinstall, and then go away. why 
then would it happen again some months later? and how would they have 
hacked it? it only runs ssh and apache. no sendmail, no bind, none of 
those usual culprits. apache is not running as root. the only other 
listener is identd.
it also runs nfsd, but connections are firewalled, from anything other 
than a 192.168.0.1 address configured on the second NIC. ah, but then i 
did accidentally open the firewall recently for a few days.

hmmm.


