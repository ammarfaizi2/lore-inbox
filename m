Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317894AbSFNJSC>; Fri, 14 Jun 2002 05:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317895AbSFNJSB>; Fri, 14 Jun 2002 05:18:01 -0400
Received: from mail.nmskb.cz ([80.95.106.16]:25358 "HELO mail.nmskb.cz")
	by vger.kernel.org with SMTP id <S317894AbSFNJRz>;
	Fri, 14 Jun 2002 05:17:55 -0400
Date: Fri, 14 Jun 2002 11:17:48 +0200
From: lkml <lkml@nmskb.cz>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bandwidth 'depredation' revisited
Message-Id: <20020614111748.6587b142.lkml@nmskb.cz>
In-Reply-To: <3D060FF6.5000409@fugmann.dhs.org>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 16:57:58 +0200
"Anders Fugmann" <afu@fugmann.dhs.org> wrote:

> To do this you can use ingress scheduler.
> 
> Something like:
> tc qdisc add dev eth0 handle ffff: ingress
> tc filter add dev etc0 parent ffff: protocol ip prio 50 u32 \
>          match ip src 0.0.0.0/0 police \
>          rate 232kbit burst 10k drop flowid :1

Try http://luxik.cdi.cz/~patrick/imq/index.html. Imq allows to shape incomming traffic with egres qdiscs.
