Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317634AbSGVPkw>; Mon, 22 Jul 2002 11:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSGVPkw>; Mon, 22 Jul 2002 11:40:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17939 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317634AbSGVPkv>; Mon, 22 Jul 2002 11:40:51 -0400
Date: Mon, 22 Jul 2002 12:43:45 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.27] Oops in tcp_v6_get_port
Message-ID: <20020722154345.GB10222@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207221324530.32636-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207221324530.32636-100000@linux-box.realnet.co.sz>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 22, 2002 at 01:25:32PM +0200, Zwane Mwaikambo escreveu:
> Hi Dave, Arnaldo
> 
> I get this whenever i run some X11 app from the 2.5.27 box and then ssh 
> in from the X server. It seems to sometimes take a while but is reproducible.

Known bug, fixed in my tree and in DaveM's too, just waiting for Linus to
merge...

Shared port space -> tcp_v6_get_port looks at the non more existing IPv6
private area on a IPv4 socket...

Wow, people are using IPv6 on 2.5! you're the third to report this and
this bug is there for months :)

- Arnaldo
