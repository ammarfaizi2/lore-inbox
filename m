Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbUDQKcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDQKcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:32:33 -0400
Received: from dialin-212-144-169-097.arcor-ip.net ([212.144.169.97]:4551 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S263799AbUDQKbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:31:31 -0400
In-Reply-To: <4080B8F4.80003@nortelnetworks.com>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <20040416144433.GE2253@logos.cnet>  <408001E6.7020001@treblig.org> <1082132015.2581.30.camel@lade.trondhjem.org> <5FF89D68-8FD9-11D8-988A-000A958E35DC@fhm.edu> <4080B8F4.80003@nortelnetworks.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-28-809344968"
Message-Id: <6E0A739C-9055-11D8-988A-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: NFS and kernel 2.6.x
Date: Sat, 17 Apr 2004 11:56:00 +0200
To: Chris Friesen <cfriesen@nortelnetworks.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-28-809344968
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On 17.04.2004, at 06:56, Chris Friesen wrote:

>> Great you want to help here. So I've a system which is NFS root using 
>> a
>> 3c940 gigabit onboard NIC on kernel 2.6.5 and which is dead fish in 
>> the
>> water somewhere in between 10 seconds and 5 minutes after boot using
>> NFS over UDP. The last thing I see are 3 or 4 messages of the type:
>
> If this is an issue, it might make sense to have root be a tmpfs 
> filesystem,
> and then have specific network mounts.

I'm trying to keep this a standard Debian system as much as possible.
Also I've several machines having a large number of shared partitions,
some of them fulfill different purposes, so I would need to customize
several instances which sounds like much work to me; part of it
certainly unnecessary because it works just fine with older kernels... 
:)

Also there is the issue that the only thing that is sort of guaranteed 
to
be transported over the network is the kernel itself. Sometimes it hangs
already when or just after loading init. I'm not convinced it will be
always able to transfer the whole ramdisk....

Forgot to mention: I've also seen segfaults and wrong file contents
in random places while init executes the scripts in /etc/rc*.d but
those seem to have gone away after I used a more conservative set
of kernel config options. Now it'll only hang.

>   Note--don't make "/var/log" network mounted, various apps default to 
> trying to check for files there--if the server goes away, you can't 
> log in/out.

There's unfortunately more to this. I also cannot log in if
any of the files (bash, bashrc, profiles, libraries, etc.)
needed for login are on nfs. The question here is what is more
reliable in terms of data transfer after an Oops: NFS or
syslogd (UDP). So far I'm satisfied with NFS here, so I don't
see a good reason to change.

Servus,
       Daniel

--Apple-Mail-28-809344968
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQID/NTBkNMiD99JrAQKgjQf8D3oGU3wlBL9tPGHETlkYrJ3wFv7O6QW3
ZXCDhyw3v68edkHO9blGWmJJHzrCZU9qsYSLfYovTU6HCcdt93OZceS56PabGQmz
nxrmtnRj7T7IwpUs47RBhJktlhntPnCN5gn3yxM4Z3MOnIwd+8agL+cgpuL53S4P
XJKQX7bvIneMcIlFb3V1732B96Mb3nvBEG0K9dHwSXMpdGBCjd8/TroDueRufNQI
mwzjqfIsLhaoG98H1t2vmAebRulvquxkzUJwRAFtX9xQ2AAaB2oee5fTVziqeL/3
cJs99Z4pvZ4o2QU50faoPVat/I22vADi6vQaYx2h558TOV3lg1vpQQ==
=k6xD
-----END PGP SIGNATURE-----

--Apple-Mail-28-809344968--

