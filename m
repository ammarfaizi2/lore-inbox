Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbRFRRId>; Mon, 18 Jun 2001 13:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbRFRRIX>; Mon, 18 Jun 2001 13:08:23 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:1721 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S261968AbRFRRIM>; Mon, 18 Jun 2001 13:08:12 -0400
Message-ID: <3B2E35C2.69CEC5D9@idcomm.com>
Date: Mon, 18 Jun 2001 11:09:22 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ted Gervais <ve1drg@ve1drg.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ipchains
In-Reply-To: <Pine.LNX.4.21.0106181256120.2050-100000@ve1drg.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Gervais wrote:
> 
> I just ran into something odd. To me anyways, it was odd.
> I just installed and brought up kernel 2.4.5 and my ipchains failed.
> So I upgraded to the latest (that I could find) ipchains-1.3.10, and
> that also fails.
> 
> Has anyone got any version of ipchains to work with the new(er) kernels?
> 
> ---
> Doubt is not a pleasant condition, but certainty is absurd.
>                 -- Voltaire
> 
> Ted Gervais <ve1drg@ve1drg.com>
> 44.135.34.201 linux.ve1drg.ampr.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

It works, but you can't load iptables modules at the same time as
ipchains. Be sure ipchains is the only module you are loading. rmmod any
iptables items before modprobe of ipchains. If you are running redhat,
also do not believe the script in /etc/rc.d/init.d/ipchains as to
whether or not ipchains is actually running, it is broken (does not
check return values), and lies and does not tell you when ipchains
startup fails (as root manually do something like ipchains -L -n).

D. Stimits, stimits@idcomm.com
