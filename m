Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRCaW4R>; Sat, 31 Mar 2001 17:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRCaW4H>; Sat, 31 Mar 2001 17:56:07 -0500
Received: from [209.125.249.111] ([209.125.249.111]:38237 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S132513AbRCaWzw>; Sat, 31 Mar 2001 17:55:52 -0500
Date: Fri, 30 Mar 2001 09:20:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Stephen Crowley <stephenc@iexchange.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, davem@redhat.com
Subject: Re: ipx wont compile in 2.4.3
Message-ID: <20010330092057.E1771@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Stephen Crowley <stephenc@iexchange.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	davem@redhat.com
In-Reply-To: <20010331135523.A4426@undertow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010331135523.A4426@undertow>; from stephenc@iexchange.com on Sat, Mar 31, 2001 at 01:55:23PM -0600
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 31, 2001 at 01:55:23PM -0600, Stephen Crowley escreveu:
> Trying to compile 2.4.3 with ipx support gives the following
> 
> net/network.o(.data+0x3e48): undefined reference to sysctl_ipx_pprop_broadcasting'

oops, Linus/David, can you please apply this?

- Arnaldo

--- linux-2.4.3/net/ipx/af_ipx.c	Fri Mar 30 08:12:58 2001
+++ linux-2.4.3.acme/net/ipx/af_ipx.c	Fri Mar 30 09:15:26 2001
@@ -123,7 +123,7 @@
 static unsigned char ipxcfg_max_hops = 16;
 static char ipxcfg_auto_select_primary;
 static char ipxcfg_auto_create_interfaces;
-static int sysctl_ipx_pprop_broadcasting = 1;
+int sysctl_ipx_pprop_broadcasting = 1;
 
 /* Global Variables */
 static struct datalink_proto *p8022_datalink;
