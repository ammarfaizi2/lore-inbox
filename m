Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUF2WjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUF2WjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUF2WjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:39:17 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:22543 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266127AbUF2WjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:39:11 -0400
Message-ID: <33785.192.168.1.9.1088548750.squirrel@192.168.1.9>
In-Reply-To: <freemail.20040529204051.42768@fm5.freemail.hu>
References: <freemail.20040529204051.42768@fm5.freemail.hu>
Date: Wed, 30 Jun 2004 00:39:10 +0200 (CEST)
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: "Redeeman" <lkml@metanurb.dk>
To: "Debi Janos" <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Reply-To: lkml@metanurb.dk
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is indeed a very strange problem.. i believe it goes longer back..
i remember when changing to 2.6.7-rc3, lkml.org didnt work.. (still dont)
and now i being to see the gentoo sites does not work, i begin to suspect
the kernel, also after seeing this thread...

i am not a expert, so i dont really know, but i didnt see anything
eyespotting that could do it in the code :|

andrew, maybe you know something? :D

> Stephen Hemminger <shemminger@osdl.org> írta:
>
>> Dave enabled the receive buffer auto-tuning which uses TCP
> window
>> scaling.  It looks like all these sites are running
> FreeBSD, perhaps
>> there is a bug in FreeBSD?
>
> packages.gentoo.org running on FreeBSD? I don't believe that.
>
> http://uptime.netcraft.com/up/graph?site=packages.gentoo.org
>
> running on Gentoo Linux,  Apache/2.0.4
>
> My site (www.hup.hu) running on FreeBSD 4.7-RC with Apache
> 1.3.29
>
> http://uptime.netcraft.com/up/graph?site=www.hup.hu
>
> it was problem with both site
>
>> As suggested earlier please get a TCP dump of a failed
> connection.
>>
>> To turn of receive buffer auto-tuning:
>> 	sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
>> 	sysctl -w net.ipv4.tcp_default_win_scale=0
>>
>> Thanks.
>
> Yes. This was the problem. With this settings working...
> Thank you.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


-- 


