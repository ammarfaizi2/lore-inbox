Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUAITlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUAITlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:41:52 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:16822 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S263653AbUAITls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:41:48 -0500
Date: Fri, 09 Jan 2004 14:41:30 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>, "Ogden, Aaron A." <aogden@unocal.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFF03EA.4060603@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigDF8BFFCC985004A828D633B9;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <3FFC96FE.9050002@zytor.com>
 <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
 <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF8BFFCC985004A828D633B9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Thu, Jan 08, 2004 at 08:52:31PM +0800, Ian Kent wrote:
>  
>
>>On Wed, 7 Jan 2004, H. Peter Anvin wrote:
>>
>>    
>>
>>>These are the mount traps Al Viro has been architecting.
>>>
>>>      
>>>
>>Please tell me about these.
>>
>>I have`nt seen any discussion on the implementation.
>>
>>Just a few sentences ....
>>    
>>
>
>Special vfsmount mounted somewhere; has no superblock associated with it;
>attempt to step on it triggers event; normal result of that event is to
>get a normal mount on top of it, at which point usual chaining logics
>will make sure that we don't see the trap until it's uncovered by removal
>of covering filesystem.  Trap (and everything mounted on it, etc.) can
>be removed by normal lazy umount.
>
>Basically, it's a single-point analog of autofs done entirely in VFS.
>The job of automounter is to maintain the traps and react to events.
>
>  
>
Is there any clear advantage to doing this in the VFS other than saving 
a superblock and a dentry/inode pair or two?

I remember talking to you about this, and I seem to recall that these 
mount traps would probably communicate using a struct file, so a 
trap-user would somehow receive events about when the trap was set 
off.   Will this communication model continue to work within a cloned 
namespace?  What happens if the trap-client closes the file?

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enigDF8BFFCC985004A828D633B9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//wPtdQs4kOxk3/MRAiUvAJ9AdoamY4cnkTfTF4eRq00Ue+6/ygCfcauv
aeslSGMIzLiEiGNx/3Pb0FY=
=Hp/r
-----END PGP SIGNATURE-----

--------------enigDF8BFFCC985004A828D633B9--

