Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCKIFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUCKIFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:05:48 -0500
Received: from [212.239.225.213] ([212.239.225.213]:32130 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261582AbUCKIFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:05:46 -0500
From: Jan De Luyck <lkml@kcore.org>
To: James Ketrenos <jketreno@linux.co.intel.com>
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
Date: Thu, 11 Mar 2004 09:05:39 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <404E27E6.40200@linux.co.intel.com> <200403110723.47400.lkml@kcore.org> <405019C2.5060409@linux.co.intel.com>
In-Reply-To: <405019C2.5060409@linux.co.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403110905.42588.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 11 March 2004 08:48, James Ketrenos wrote:
> Jan De Luyck wrote:
> >>I can't test the actual transmitting since I've got no accesspoint handy.
> >>Will do so when at home, though.
> >
> > Tested this. It works, _if_ you set the AP address first, otherwise it
> > bails out with 'Fatal interrupt'.
>
> So you're doing something like:
>
> # modprobe ipw2100
> # iwconfig eth1 ap 00:0d:88:28:2e:91
> # ifconfig eth1 up

I believe I wasn't awake when I typed that mail ;p

The problem is that if you try to set an IP using DHCP (in my case ISC dhcpcd  
version 1.3.22pl4) without first enabling your interface, you get a fatal 
interrupt.

If you enable your interface, then do a dhcp request, it works.

Why I got mixed up with the ap setting is that I first thought that was the 
problem (since iwconfig eth1 showed 00:00:00:00:00:00 instead of the mac 
address of the AP. It was shown in /proc/iwp2100/eth1/bssconfig though)

> Btw, thanks for your prior post with the oops info.  There is a fix in the
> latest snapshot (0.30) on http://ipw2100.sf.net.

Yup, I'm compiling that one (together with 2.6.4) right now.

Maybe this should be cc-ed to the devel mailing list too?

Jan

- -- 
You see but you do not observe.
Sir Arthur Conan Doyle, in "The Memoirs of Sherlock Holmes"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUB3VUQQOfidJUwQRAix/AJ9GdhYEH/MlK8AToIgnHVpdIuekywCfYQ9V
SqTUbdIeZVEDrhoSt+HJ9z0=
=Nej6
-----END PGP SIGNATURE-----
