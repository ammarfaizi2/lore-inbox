Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbUKRGwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUKRGwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUKRGwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:52:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:43187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262641AbUKRGwH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:52:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j2S3pz2RjzulXkIBPDiwHIXKy8ziicjwRy0l7nDJtLwmDvjA0m2rsIe9WTY1IJKTg4k3G/H/tnYo34Eaq4adtkXGhYiOvJ6AFksbS2Gp3L1mjT5YzachzMmVoAG2JArOKY9rywPZfV/oDFTN3dBJUKelf4VSNosy5BX2k/2kO4Q=
Message-ID: <7153331f04111712467a00b60d@mail.gmail.com>
Date: Wed, 17 Nov 2004 15:46:11 -0500
From: Don Lafontaine <don.lafontaine@gmail.com>
Reply-To: Don Lafontaine <don.lafontaine@gmail.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Packet capturing, iptables and eth0 vs. dummy0
In-Reply-To: <20041117203033.GA7907@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20041117203033.GA7907@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's because when you try locally, you end up using lo0, not eth0.


On Wed, 17 Nov 2004 21:30:33 +0100, DervishD <lkml@dervishd.net> wrote:
>    Hi all :)
> 
>    I've noticed that, no matter what filtering is iptables doing,
> tcpdump gets all packets from interface eth0 as seen in the bus, but
> doesn't do the same in dummy0. I'll explain it further...
> 
>    Let's say that I'm filtering all incoming TCP SYN packets on all
> interfaces that have a destination port of 6666 (for example), and
> I'm listening, with tcpdump, to all packets in eth0. Well, I use
> another computer to try to connect to port 6666 of the machine
> running tcpdump and the packet filter, and obviously I'm unable to
> connect (without the filter I can do it normally), but I see the SYN
> packets in the output of tcpdump.
> 
>    If I do exactly the same from the machine running tcpdump and the
> filter, I cannot connect (without the filter I can), but no output
> comes from tcpdump, which is exactly what I expected in the case
> explained in the paragraph above.
> 
>    Is is normal? Is normal that tcpdump shows packets before they
> enter the filter when the interface is a real one (eth0) but no when
> you access through a dummy interface or localhost, or am I missing
> anything?
> 
>    Thanks a lot in advance :)
> 
>    Raúl Núñez de Arenas Coronado
> 
> --
> Linux Registered User 88736
> http://www.dervishd.net & http://www.pleyades.net/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Don Lafontaine
http://www.avsim.com/hangar/utils/freefd
