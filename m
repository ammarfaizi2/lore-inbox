Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSDXSOE>; Wed, 24 Apr 2002 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSDXSOD>; Wed, 24 Apr 2002 14:14:03 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:20134 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S312505AbSDXSN5>;
	Wed, 24 Apr 2002 14:13:57 -0400
Date: Wed, 24 Apr 2002 14:13:55 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Message-ID: <20020424141355.B20763@havoc.gtf.org>
In-Reply-To: <20020424.093515.82125943.davem@redhat.com> <721506265.avixxmail@nexxnet.epcnet.de> <20020424.095951.43413800.davem@redhat.com> <3CC6EBF1.9060902@candelatech.com> <20020424134933.A17852@havoc.gtf.org> <20020424210723.L1284@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 09:07:23PM +0300, Matti Aarnio wrote:
> On Wed, Apr 24, 2002 at 01:49:33PM -0400, Jeff Garzik wrote:
> ...
> > The tulip patch is butt-ugly - the oversized allocation isn't needed,
> > and it just flat-out turns off large packet protection.  That's really
> > not what you want to do, even for the best tulip cards.  If an oversized
> > gram (non-VLAN) makes it into a network which such a patched tulip
> > driver, you can DoS. 
> 
>   It all depends...  At least the cisco switches I have used have
>   protection by controlling on how large frames you can send, and
>   having automatic enlarging of frame size for VLAN Trunking port.
> 
>   Of course those switches have some amounts of "jumbogram support"
>   as well at port by port basis.
>  
>   So perhaps you can DoS your machine off the net (or your stream
>   very least), but not other machines.

The DoS certainly assumes that one can send jumbo datagrams to the
target machine via a local network.  There are a multitude of ways
one can prevent the DoS present in the tulip VLAN patch, what you
name is certainly one of them.

	Jeff


