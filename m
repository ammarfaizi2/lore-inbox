Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285041AbRLQIUx>; Mon, 17 Dec 2001 03:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285048AbRLQIUc>; Mon, 17 Dec 2001 03:20:32 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:37292 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S285041AbRLQIUW> convert rfc822-to-8bit; Mon, 17 Dec 2001 03:20:22 -0500
From: Christoph Rohland <cr@sap.com>
To: =?iso-8859-1?q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: Is /dev/shm needed?
In-Reply-To: <E16FkV9-00010E-00@DervishD.viadomus.com>
Organisation: SAP LinuxLab
Date: 17 Dec 2001 09:19:01 +0100
In-Reply-To: <E16FkV9-00010E-00@DervishD.viadomus.com>
Message-ID: <m3heqqi7ii.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RaúlNúñez,

On Mon, 17 Dec 2001, RaúlNúñez de Arenas Coronado wrote:
>     Hello Robert :)
> 
>>It is not needed.  /dev/shm mounted with tmpfs is only needed for
>>POSIX shared memory, which is still fairly rare.
> 
>     That this means that I can mount more than one 'tmpfs' just like
> if it's a *real* filesystem? I wasn't sure, since it's implemented
> thru the page cache.

Yes, every single mount is an independant tree.

>>It is dynamic, so you don't need to specify a size.
> 
>     Yes, I knew, I meant the maximum size. I don't want half of the
> RAM occupied just by a programming mistake ;)))

What I like most about /tmp in tmpfs is the ability to resize on the
fly: I have a big swap partition and a reasonable limit for /tmp and
/var/tmp.

When one of these gets full I can either stop the affending job or
increase the limit: If there is swap left I can simply increase the
limit. If swap is full I add a swap file on a real filesystem and
increase the limit.

Greetings
		Christoph

P.S: Documentation/filesystems/tmpfs.txt is in the 2.4.17-rc patch.

