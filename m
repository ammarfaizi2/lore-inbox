Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVBXRCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVBXRCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVBXRCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:02:03 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:49361 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262423AbVBXRBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:01:50 -0500
Message-ID: <421E08AA.905@free.fr>
Date: Thu, 24 Feb 2005 18:02:34 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, helge.hafting@aitel.hist.no
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
References: <20050223014233.6710fd73.akpm@osdl.org>	<421C7FC2.1090402@aitel.hist.no>	<20050223121207.412c7eeb.akpm@osdl.org>	<421D0582.9090100@free.fr> <20050223152038.08f7d7e0.akpm@osdl.org>
In-Reply-To: <20050223152038.08f7d7e0.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig71A36D2D2AB54248AE1DFF8E"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig71A36D2D2AB54248AE1DFF8E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Le 24.02.2005 00:20, Andrew Morton a écrit :
> Laurent Riffard <laurent.riffard@free.fr> wrote:
>
>>Le 23.02.2005 21:12, Andrew Morton a écrit :
>>
>>>Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>>>
>>>
>>>>This kernel came up, but my boot script complained about no /dev/hdb3
>>>>when trying to mount /var.
>>>>(I have two IDE disks on the same cable, and an IDE cdrom on another.)
>>>>They are usually hda, hdb, and hdc.
>>>>
>>>>MAKEDEV hdq did not help.  Looking at sysfs, it turns out that
>>>>/dev/hdq1 is at major:3 minor:1025 if I interpret things right.
>>>>(/dev/hda1 is at 3:1, which is correct.)
>>>>These numbers did not work with my mknod, it created 7:1 instead.
>>>>So I didn't get to test this mysterious device.
>>>>
>>>>But I assume this is a mistake of some sort, I haven't heard about any
>>>>change in the IDE numbering coming up?  2.6.1-rc3-mm1 works as expected.
>>>>
>>>>It may be interesting to note that my root raid-1 came up fine,
>>>>consisting of hdq1 and hda1 instead of the usual hdb1 and hda1.
>>>
>>>
>>>I don't know what could be causing that.  Please send .config.  If you set
>>>CONFIG_BASE_FULL=n, try setting it to `y'.
>>>
>>
>>this is just a "me too"...
>
>
> Confusing.  Are you saying that the hdd->hdq problem is happening even with
> CONFIG_BASE_FULL=y?
>

yes, I do.

--
laurent

--------------enig71A36D2D2AB54248AE1DFF8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCHgi0UqUFrirTu6IRAsnhAKCI2h+rpXYqQCqsGpUO3qyIy/K+ogCfd8Vm
0StGFPWOa7IdDo6Ebw65nog=
=oSJb
-----END PGP SIGNATURE-----

--------------enig71A36D2D2AB54248AE1DFF8E--
