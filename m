Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCACC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCACC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 21:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVCACC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 21:02:57 -0500
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:4102 "EHLO
	h80ad25cd.async.vt.edu") by vger.kernel.org with ESMTP
	id S261197AbVCACCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 21:02:55 -0500
Message-Id: <200503010202.j2122b80025303@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jarne Cook <jcook@siliconriver.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complicated networking problem 
In-Reply-To: Your message of "Mon, 28 Feb 2005 14:59:31 +1000."
             <200502281459.31402.jcook@siliconriver.com.au> 
From: Valdis.Kletnieks@vt.edu
References: <200502281459.31402.jcook@siliconriver.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109642557_3594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Feb 2005 21:02:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109642557_3594P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Feb 2005 14:59:31 +1000, Jarne Cook said:

> They are both using dhcp to the same simple network.  That's right.  Same 
> network.  They both end up with gateway=192.168.0.1, netmask=255.255.255.0.  
> But ofcourse they do not have the same IP addresses.

I don't suppose your network people would be willing to change it thusly:

wired ports:  gateway 192.168.0.1, netmask 255.255.255.128.0
wireless:     gateway 192.168.128.1, netmask 255.255.255.128.0

Or move the wireless up to 192.168.1.1 if they think that would confuse things
too much.

There's a limit to how far we should bend over backwards to support stupid
networking decisions. 192.168 *is* a /16, might as well use it. ;)

If they won't, you're pretty much stuck with binding applications to one
interface or another.

--==_Exmh_1109642557_3594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCI809cC3lWbTT17ARAhtwAKDticfO9dAWeplrp5F4kHvB8VUIAQCeIDnD
E2C8gfnUfNzcAARudP+Am6k=
=8HqR
-----END PGP SIGNATURE-----

--==_Exmh_1109642557_3594P--
