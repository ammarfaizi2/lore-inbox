Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275096AbRJNMBR>; Sun, 14 Oct 2001 08:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275097AbRJNMBG>; Sun, 14 Oct 2001 08:01:06 -0400
Received: from Expansa.sns.it ([192.167.206.189]:15115 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S275096AbRJNMAy>;
	Sun, 14 Oct 2001 08:00:54 -0400
Date: Sun, 14 Oct 2001 14:01:07 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Aaron Lehmann <aaronl@vitelus.com>,
        "peter k." <spam-goes-to-dev-null@gmx.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: iptables v1.2.3: can't initialize iptables table `filter': Module
 is wrong version
In-Reply-To: <Pine.LNX.3.96.1011013160400.28071B-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110141354250.16843-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ummmmh... I have a friend with similar problems, and I discovered
he was using iptables 1.2.2 with shared object from 1.2.1. But I do not
think this is your case. Unfortunatelly I lost the first post, so if you
are so kind to resend it to me, I could check.
iptables 1.2.3 has also another bug, when you are using the TOS shared
object (that is the  on my box /usr/lib/iptables/libipt_tos.so), to
mangle TOS, you cannot use any decimal value or exadecimal value as
argument for the --set-tos option. I saw other people have this bug, but
there are also  people that are not seeing this behaviour (??? I am
confused about this).
Anyway, there are also other details because of whom I would suggest to
stay with iptables 1.2.2 for now.

Luigi


On Sat, 13 Oct 2001, Jeff Garzik wrote:

> On Sat, 13 Oct 2001, Aaron Lehmann wrote:
> > On Sat, Oct 13, 2001 at 01:05:33PM +0200, peter k. wrote:
> > > iptables keeps telling me that whenever i run it although i got the latest
> > > kernel, latest iptables and all modules required for iptables are loaded (it
> > > also doesnt work when i compile them into the kernel)!
> > > anyone got an idea how to fix this?
> >
> > did you compile your iptables against the version/configuration of the
> > kernel you are trying to run?
>
> I am getting the same thing here.  I am using iptables 1.2.2 SRPMS from
> Mandrake 8.1, compiled against the latest 2.4 kernel.  Same message as
> in $subject.  I poked through the source and found that "module is wrong
> version" is the standard text message for the error code EINVAL, which
> is rather silly and uninformative.
>
> I built ipchains compatibility module, and am about to install ipchains
> and see if I can get things working that way...
>
> 	Jeff
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

