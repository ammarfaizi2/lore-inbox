Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXBJR>; Sat, 23 Dec 2000 20:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLXBJI>; Sat, 23 Dec 2000 20:09:08 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:56850 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129458AbQLXBIv>; Sat, 23 Dec 2000 20:08:51 -0500
Date: Sat, 23 Dec 2000 22:38:14 -0200
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-ID: <20001223223814.A2281@flower.cesarb>
In-Reply-To: <20001223213156.A1947@flower.cesarb> <NCBBLIEPOCNJOAEKBEAKKEPOMJAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKKEPOMJAA.davids@webmaster.com>; from davids@webmaster.com on Sat, Dec 23, 2000 at 04:19:31PM -0800
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 04:19:31PM -0800, David Schwartz wrote:
> 
> > This means that keepalive is useless for keeping alive more than
> > one connection
> > to a given host.
> 
> 	Actually, keepalive is useless for keeping connections alive anyway. It's
> very badly named. It's purpose is to detect dead peers, not keep peers
> alive.

Then what do you do when you are behind a NAT? And how do you expire entries in
ESTABLISHED state that could stay lingering forever without some sort of
keepalive? (The FINs might have been lost due to a conectivity transient, so
you can have another perfectly valid and alive connection with the same host,
and application-level timeouts are useless for some applications
(*cough*nc*cough*))

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
