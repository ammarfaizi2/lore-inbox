Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBNQmQ>; Wed, 14 Feb 2001 11:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBNQmH>; Wed, 14 Feb 2001 11:42:07 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:13736 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129075AbRBNQlu>; Wed, 14 Feb 2001 11:41:50 -0500
Message-ID: <3A8AB4A3.C12E7E7B@sympatico.ca>
Date: Wed, 14 Feb 2001 11:38:59 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: TeknoDragon <andross@ghettobox.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Destination Loose UDP in 2.4 (net/ipv4/netfilter)
In-Reply-To: <Pine.LNX.4.32.0102132146560.7508-100000@ghettobox.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TeknoDragon wrote:

> What is the status of "dloose udp" in 2.4.x? From my reading in a few list
> archives it seems to have been some sort of a hack, yet it is needed for
> games such as Asheron's Call to be played behind a firewall.

I use Starcraft behind a 2.4.0 (RH7) masq firewall using
netfilter/nat/iptables and it works fine by default.

iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE  (or something very
close)

Under redhat 6.2, stock kernel, it also worked.  Under 7.0 stock kernel, I
had to echo 1 to that
/proc file you mention below.

>
>
> In 2.2.18 the code implementing this seems to be in net/ipv4/ip_masq.c
> and was controlled by a sysctl "ip_masq_udp_dloose".
>
> Is there anything in 2.4.x to replace this functionallity? Is there a way
> to replace it with an iptables rule? Any help would be much appreciated.
>
> -karl
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

