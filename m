Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271697AbRH0Kwu>; Mon, 27 Aug 2001 06:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271699AbRH0Kwl>; Mon, 27 Aug 2001 06:52:41 -0400
Received: from iproxy1.ericsson.dk ([130.228.248.98]:9409 "EHLO
	iproxy1.ericsson.dk") by vger.kernel.org with ESMTP
	id <S271697AbRH0Kwb>; Mon, 27 Aug 2001 06:52:31 -0400
Message-ID: <3B8A262C.82ED7793@ted.ericsson.dk>
Date: Mon, 27 Aug 2001 12:51:24 +0200
From: Fabbione <fabio.m.d.nitto@ted.ericsson.dk>
Reply-To: fabbione@fabbione.net
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Possibly OT] ipt_unclean.c on kernel-2.4.7-9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gurus,
	I've possibly found a bug in the iptables unclean match support
but I was not able to find the email of the mantainer so I'm posting
here....

the module is incorrectly matching ftp session. Ex:

iptables -j DROP -A INPUT --match unclean
iptables -j ACCEPT -A INPUT -p tcp --dport 21

in this case all my packets directed to the ftp server where dropped by
the
"unclean" match and this make impossible to open ftp session.

It's obvious that you can swap the entry to make it working but I think
it should work also in this way. I've also tested using different
client.

If people need more info jus ask please.

Fabbione
