Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbULCJfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbULCJfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbULCJfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:35:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:47513 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262119AbULCJeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:34:50 -0500
X-Authenticated: #4512188
Message-ID: <41B03337.5090408@gmx.de>
Date: Fri, 03 Dec 2004 10:34:47 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202130457.GC10458@suse.de>	<20041202134801.GE10458@suse.de>	<20041202114836.6b2e8d3f.akpm@osdl.org>	<20041202195232.GA26695@suse.de>	<20041202121938.12a9e5e0.akpm@osdl.org>	<41AF94B8.8030202@gmx.de>	<20041203070108.GA10492@suse.de>	<41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org>
In-Reply-To: <20041203012645.21377669.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAF226BFECE58BA6FBB562D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAF226BFECE58BA6FBB562D3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton schrieb:
> "Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
> 
>>>Can you try with the patch that is in the parent of this thread? The
>>
>> > above doesn't look that bad, although read performance could be better
>> > of course. But try with the patch please, I'm sure it should help you
>> > quite a lot.
>> > 
>>
>> It actually got worse: Though the read rate seems accepteble, it is not, as 
>> interactivity is dead while writing.
> 
> 
> Is this a parallel IDE system?  SATA?  SCSI?  If the latter, what driver
> and what is the TCQ depth?

Hmm yes, this is a RAID0 configuration, so the regression of time 
slieced CFQ might me related to it, but the problem of unresponsiveness 
while writing as such was on my single disk, as well. Here one HD is 
SATA (libata silicon image) and one on IDE controller (nforce2). No TCQ. 
BTW, I haven't checked the problem on my ide disk only on SATA. Wil try 
to free some space and do so...

Prakash

--------------enigCAF226BFECE58BA6FBB562D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsDM3xU2n/+9+t5gRAh6mAKDVLBkKuqsJUkHzBT51fVWylkcV/wCfSuUH
q5a4mqZp288Ak1szIZrgD9k=
=Fclg
-----END PGP SIGNATURE-----

--------------enigCAF226BFECE58BA6FBB562D3--
