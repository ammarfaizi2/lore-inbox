Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUBTNxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUBTNuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:50:01 -0500
Received: from terra.irts.fr ([194.206.161.9]:60350 "EHLO ns1.terranet.fr")
	by vger.kernel.org with ESMTP id S261207AbUBTNtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:49:02 -0500
Message-ID: <40360FDD.1070607@laposte.net>
Date: Fri, 20 Feb 2004 14:47:09 +0100
From: MALET JL <malet.jean-luc@laposte.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.5) Gecko/20031007
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [drivers][sata-promise] TX4 has the cache enabled, it should
 be disabled
References: <4031DB3E.8000406@laposte.net> <40354871.1060009@pobox.com>
In-Reply-To: <40354871.1060009@pobox.com>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAA0EE5C6A37CD68BD2B70A7E"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA0EE5C6A37CD68BD2B70A7E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Jeff Garzik a écrit :

> MALET JL wrote:
>
>> hello,
>> I've a TX4 150 card and encounter the following effects :
>> ->"shorts" files (<1Mo) are copied at 35Mo/s av
>> ->"long" files (>1Mo) are "burst" copied (ie a big "burst" then 
>> hangs, burst, hangs) this has the following effects :
>> 1) average fall back to 12Mo/s
>> 2) systems "hangs" (mouse, keyboard behave like a 100% used cpu) but 
>> cpu usage is still slow
>> 3) mplayer reset the streams every second (cpu usage still low)
>>
>> this is 1-2 week that I have this issue, but can't find where it 
>> comes from...... yesterday by chance when I loaded sata-promise I 
>> noticed "write through" this remembered be some issue I go when I 
>> first had the sata board, making a short research made me remember :
>>
>> DISABLE THE BOARD CACHE! on windows this is the same when cache is 
>> enabled : performance drops, system interactive is awfull....
>
>
>
> There is no on-board cache on the TX4.
>
> Further, you are thinking about the SCSI layer's caching support, i.e. 
> basically whether the driver supports SYNCHRONIZE CACHE (aka 
> flush-cache) scsi command.
>
>     Jeff
>
I relooked into manual (see promise site support, user manual)  and 
there are two parameters for TX4 : write through/ write back , cache on 
cache off..... I don't know which cache is it about but I'll redo some 
test (argh you oblige me to reboot to windows! did you thought of my 
uptime! LOL )this evening but as far as I remember the optimal values 
where write through /no cache.....
on windows with cache on their was small hangs too....
I noticed then that a prempible kernel is not a good idea in my case : 
lot more "small hangs"......
JLM



--------------enigAA0EE5C6A37CD68BD2B70A7E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFANg/dcl3j/qUaL14RAsecAJ40sSkGEUc9cshUlcngkiu60iF66gCcDlkU
2XQK5tXuzrAtN3zdUZuNMA8=
=fRjj
-----END PGP SIGNATURE-----

--------------enigAA0EE5C6A37CD68BD2B70A7E--

