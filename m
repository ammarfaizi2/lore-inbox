Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144574AbRA2AVk>; Sun, 28 Jan 2001 19:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144590AbRA2AVb>; Sun, 28 Jan 2001 19:21:31 -0500
Received: from 4-035.cwb-adsl.brasiltelecom.net.br ([200.193.163.35]:39928
	"HELO brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S144574AbRA2AVW>; Sun, 28 Jan 2001 19:21:22 -0500
Date: Sun, 28 Jan 2001 20:37:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.1-pre11
Message-ID: <20010128203703.T19833@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3A74B16D.6020304@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A74B16D.6020304@bellsouth.net>; from louisg00@bellsouth.net on Sun, Jan 28, 2001 at 06:55:25PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 28, 2001 at 06:55:25PM -0500, Louis Garcia escreveu:
> I am getting messages everytime I use the network from my RH7 + 
> kernel-2.4.1-pre11 system:
> 
> modprobe: modprobe: Can't locate module net-pf-10
> 
> I have checked my .config  and can't find that modules. This does not 
> happen with 2.4.0 kernel, only with the latest pre series maybe pre7 on.

you haven't included support for IPv6 and your distribution initscripts is
trying to load it for some reason, two solutions:

1. enable IPv6 in your kernel build
2. disable it in your /etc/modules.conf file, like this:

alias net-pf-10 off

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
