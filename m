Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbULCJhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbULCJhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbULCJhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:37:41 -0500
Received: from mail.gmx.de ([213.165.64.20]:11200 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262124AbULCJfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:35:52 -0500
X-Authenticated: #4512188
Message-ID: <41B03375.4050702@gmx.de>
Date: Fri, 03 Dec 2004 10:35:49 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203091840.GD10492@suse.de>
In-Reply-To: <20041203091840.GD10492@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD03E9D96A067470F0BA17AF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD03E9D96A067470F0BA17AF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> 
>>Jens Axboe schrieb:
>>
>>>On Thu, Dec 02 2004, Prakash K. Cheemplavam wrote:
>>>
>>
>>>>0  3   3080   2208   1156 817712    0    0  3592 75624 1326  2289  1 36  
>>>>0 63
>>>>0  3   3080   2664   1156 818240    0    0  5124 15692 1302   992  1 18  
>>>>0 81
>>>>0  3   3080   2580   1160 815832    0    0  4356 155792 1375  1064  1 39  
>>>>0 60
>>>>0  3   3080   2472   1160 817124    0    0  3076 100852 1345  1138  1 23  
>>>>0 76
>>>>2  4   3080   2836   1148 816228    0    0  3336 100412 1352  1379  1 47  
>>>>0 52
>>>>0  4   3080   2708   1144 815964    0    0  3844 48908 1343   871  1 25  
>>>>0 74
>>>>0  3   3080   2748   1152 815984    0    0  3332 71996 1338   843  1 27  
>>>>0 72
>>>
>>>
>>>Can you try with the patch that is in the parent of this thread? The
>>>above doesn't look that bad, although read performance could be better
>>>of course. But try with the patch please, I'm sure it should help you
>>>quite a lot.
>>>
>>
>>It actually got worse: Though the read rate seems accepteble, it is not, as 
>>interactivity is dead while writing. I cannot start porgrammes, other 
>>programmes which want to do i/o pretty much hang. This is only while 
>>writing. While reading there is no such problem.
> 
> 
> Interesting, thanks for testing. I'll run some tests here as well, so
> far only the cases mentioned yesterday have been tested.

BTW, in case it is misread: Above (except the io performance as such) is
no regression: The other schedulers behave the same on my system.


> You could try and bumb the slice period. But I'll experiment and see
> what happens. What is your test case?

[slice bumping] Uhm, is it doable via proc? I haven't seen text docs to
your patch and I am not good at kernel code ;-)

My test case was apkm's one: write 1gb continuesly and try to cat a
several gb big file to /dev/null. At the same time I checked starting
other apps/using my emial client...

For me the problem in mainline has been since quite some time...checked 
till kernel 2.6.7.

Prakash

--------------enigBD03E9D96A067470F0BA17AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsDN1xU2n/+9+t5gRAqF8AKDAq3fs7wGb5ewE6quO0+FBhCpwLwCgqVkA
Z+3vt4HEKDcVrhp3DYr4dTg=
=MeFx
-----END PGP SIGNATURE-----

--------------enigBD03E9D96A067470F0BA17AF--
