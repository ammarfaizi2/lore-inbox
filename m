Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275911AbTHOLuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHOLuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:50:05 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:60301 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263638AbTHOLt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:49:57 -0400
Date: Fri, 15 Aug 2003 14:49:45 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Ricardo Galli <gallir@uib.es>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.0: Bad udp checksum in loopback interface (me too!)
In-Reply-To: <200308151311.48831.gallir@uib.es>
Message-ID: <Pine.LNX.4.56.0308151447580.656@hosting.rdsbv.ro>
References: <200308151311.48831.gallir@uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have almost the same program.
cups sends on udp browse informations.
It sends 3 + 1 udps.
The last one has bad checksum.


> tcpdump -v shows bad udp checksum in the loopback interface. But I'm not sure
> if the packets is discarded or the error is ignored.
>
> ponti:~# tcpdump -i lo -n -v
>
> ponti:~# dig @192.168.0.3 gallimedina.net
>
> 13:02:12.360728 192.168.0.3.32827 > 192.168.0.3.53: [bad udp cksum 5e6d!]
> 35220+ A? gallimedina.net. (33) (DF) [ttl 0] (id 0, len 61)
> 13:02:12.364470 192.168.0.3.53 > 192.168.0.3.32827:  35220* 1/1/1
> gallimedina.net. A 192.168.0.10 (85) (DF) [ttl 0] (id 12492, len 113)
>
> ponti:~# dig @127.0.0.1 gallimedina.net
>
>
> 13:03:53.299883 127.0.0.1.32827 > 127.0.0.1.53: [bad udp cksum 167d!]  32901+
> A? gallimedina.net. (33) (DF) [ttl 0] (id 0, len 61)
> 13:03:53.303448 127.0.0.1.53 > 127.0.0.1.32827:  32901* 1/1/1 gallimedina.net.
> A 192.168.0.10 (85) (DF) [ttl 0] (id 7725, len 113)
>
>
>
> This machine has a bridge, but I also tried in another one with netcat (nc -l
> -u localhost -p 2000 and nc -u localhost 2000)
>
> antoli:~# tcpdump -i lo -n -v
> tcpdump: listening on lo
> 13:09:04.125385 127.0.0.1.32890 > 127.0.0.1.2000: [bad udp cksum 5a0!] udp 14
> (DF) [ttl 0] (id 32006, len 42)
> 13:09:12.472940 127.0.0.1.2000 > 127.0.0.1.32890: [bad udp cksum 837!] udp 7
> (DF) [ttl 0] (id 34086, len 35)
>
>
> I saw the short message does arrive to the listening netcat, but tcpdump still
> gives the bad udp error message.
>
> Regards,
>
> --
>   ricardo galli       GPG id C8114D34
>   http://mnm.uib.es/~gallir/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
