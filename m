Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTKRA2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKRA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:28:10 -0500
Received: from ns.media-solutions.ie ([212.67.195.98]:47887 "EHLO
	mx.media-solutions.ie") by vger.kernel.org with ESMTP
	id S262196AbTKRA2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:28:02 -0500
Message-ID: <3FB96718.20103@media-solutions.ie>
Date: Mon, 17 Nov 2003 18:26:00 -0600
From: Keith Whyte <keith@media-solutions.ie>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: es-mx, es-es, en, en-us
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>, linux-kernel@vger.kernel.org,
       linux-gcc@vger.kernel.org, linux-admin@vger.kernel.org
Subject: Re: 2.4.18 fork & defunct child.
References: <1069053524.3fb87654286b5@ssl.buz.org> <3FB8E40F.EF61CA7@gmx.de>
In-Reply-To: <3FB8E40F.EF61CA7@gmx.de>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RelayImmunity: 212.67.195.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:

{ strace listing deleted, see 
http://marc.theaimsgroup.com/?l=linux-kernel&m=106905386725308&w=2 }

>That is not normal /bin/true behaviour.  Sure your system
>isn't hacked?  Give the -f option to ptrace to see what the
>forked process is trying to do...  Compare the size of
>/bin/true with a known-good one.
>
>Ciao, ET.
>

I'm not sure. I should be running tripwire or something, this is the 
only one of my systems that doesn't run such a thing, as i have the  
firewall locked down and have been busy.
But it is true i accidently did iptables -F and it was left that way for 
a few days.

But this happens with any program, not just /bin/true, also the 
/bin/true on the root and chroot systems are identical. and with much 
interest i discovered, that if i unmount /proc, the problem goes away. aggh.

that is why it is not exhibiting itself in the chroot system, - no /proc.

I also remember that when this first happen nearly a year ago, some 
"unix engineer" at the ISP said, oh yeah that's because something in the 
ext2 filesystem header is corrupted.. i don't quite remember what he 
said exactly, something  that sounded so far fetched that i ignored it. 
does that ring any bells with anyone?

please help, ug, i hate having a linux system that's not reliable. feels 
like having a pet that's in pain or something.

btw,
/lib/libc.so.6 -> libc-2.2.5.so

Keith

(i'm cross-posting here to gcc and admin in the hopes of finding someone 
who has seen this, thanks!)



