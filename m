Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLXALx>; Sat, 23 Dec 2000 19:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbQLXALn>; Sat, 23 Dec 2000 19:11:43 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:54537 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129595AbQLXALe>; Sat, 23 Dec 2000 19:11:34 -0500
Date: Sat, 23 Dec 2000 21:31:56 -0200
To: linux-kernel@vger.kernel.org
Subject: TCP keepalive seems to send to only one port
Message-ID: <20001223213156.A1947@flower.cesarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been doing some experiments with the keepalive code in 2.4.0-test10 here
(I want to avoid the 2.2.x NAT I'm using (for which I don't have root) from
 timing out my connections). To test it, I reduced both tcp_keepalive_time and
tcp_keepalive_intvl to 1. Using ethereal, I saw that the keepalives were sent
as expected, but only for one of the two idle TCP connections I had to a given
host (I was testing with two remote hosts, each with two idle TCP connections,
one in port 5500 and the other in port 5501). I only saw activity on 5500, yet
netstat told me both were still active.

This means that keepalive is useless for keeping alive more than one connection
to a given host.

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
