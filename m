Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSDWNkS>; Tue, 23 Apr 2002 09:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSDWNkR>; Tue, 23 Apr 2002 09:40:17 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:58091 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S315200AbSDWNkO>;
	Tue, 23 Apr 2002 09:40:14 -0400
Date: Tue, 23 Apr 2002 09:40:13 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Frank Louwers <frank@openminds.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423094013.A27946@havoc.gtf.org>
In-Reply-To: <20020423113935.A30329@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 11:39:35AM +0200, Frank Louwers wrote:
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
> 
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!
> 
> Even if we disconnect the cable for eth1, 1.2.3.2 still replies to
> pings, ssh, web, ...

If the two NICs are on the same network, the kernel will send the
packets to the first available interface.

The kernel has acted like this for years...

	Jeff



