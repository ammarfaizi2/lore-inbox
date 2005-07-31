Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVGaGLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVGaGLb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 02:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVGaGLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 02:11:31 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:10135 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261678AbVGaGL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 02:11:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=37Z3rvcuXs9ouQ0AOhBUOx4imN5EBHBaV8LPnHiTlUg4FOwSgRHRDjikQ27VsZEYQYfBVP/UiCspP7UObvyROPk6eQyAXj87engUp5gXXaKW2FATyzwfvFZq1mpRzJlrY+iezfukoSHIV68lZSl9DOp4XmwTA3fVniKNbjjgXO8=  ;
Message-ID: <42EC73B2.8020400@yahoo.com.br>
Date: Sun, 31 Jul 2005 03:46:10 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>	<105c793f05072507426fb6d4c9@mail.gmail.com>	<42E59E0E.5030306@yahoo.com.br>	<20050726003322.1bfe17ee.akpm@osdl.org>	<42E7A153.6060307@yahoo.com.br>	<20050727105005.30768fe3.akpm@osdl.org>	<42E85E6E.2020105@yahoo.com.br>	<42EC5451.7010907@yahoo.com.br>	<20050730222624.73337021.akpm@osdl.org>	<42EC6BAB.5020106@yahoo.com.br> <20050730224437.4088ba70.akpm@osdl.org>
In-Reply-To: <20050730224437.4088ba70.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Andrew Morton wrote:
>>
>>>"Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
>>>
>>>
>>>>udev          S 00000002     0  1312      1                1224 (NOTLB)
>>>>c1653f4c 00000082 c1653f3c 00000002 00000001 00000040 c1653f64 c1653f0c
>>>>       c016611b bfec96a8 c1653f0c 00000040 00000000 00000361 000241ed
>>>>c13fb520
>>>>       00000001 00001a7e 98f9769f 00000002 c146e520 df5da020 df5da148
>>>>c13fbf60
>>>>Call Trace:
>>>> [<c016611b>] cp_new_stat+0x15f/0x17a
>>>> [<c0352a74>] schedule_timeout+0x54/0xa2
>>>> [<c01274ce>] process_timeout+0x0/0x9
>>>> [<c01275c4>] sys_nanosleep+0xdd/0x18e
>>>> [<c0102e85>] syscall_call+0x7/0xb
>>>
>>>
>>>Well there's your delay: you've started running userspace and udev is
>>>running.  Yes, it takes a long time.
>>>
>>>What makes you think this isn't normal behaviour?  Do other kernels behave
>>>differently with the same userspace setup?
>>>
>>
>>
>>That's the point. On kernel 2.6.11 on same box I have no delay. It is
>>instantaneous. On 2.6.12-rc1 it was instantaneous but I didn't use it
>>much because I had drm problems. Later I tried 2.6.12 final and it was
>>hanging. I saw the "seeing a minute plugs hangs" on 2.6.13-rc1 release
>>notes and thought this could be the problem, but I compiled it and tried
>>with no luck :(
>>
>>Now, I'm thinking it could be something like the udev hang which
>>disapeared with udev update to 058.
>>
>>I don't know what can be happening. I think it is because of some type
>>of timeout.
>>
>>If you think there is something else I can do, please let me know.
>>
> 
> 
> Greg said in another thread: "older versions of udev (< 058) can work
> _really slow_ with 2.6.12.  Please upgrade your version of udev and see if
> that solves the issue or not.".
> 
> What version are you running?   Looks like 058, yes?


Yeap. It is 058.


- --
Regards,

Francisco Figueiredo Jr.
Npgsql Lead Developer
http://gborg.postgresql.org/project/npgsql
MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org


- -------------
"Science without religion is lame;
religion without science is blind."

                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQuxzsv7iFmsNzeXfAQJ99Af/WUwTSnUi8HJk10jwTJw7ad0+09Hbf0r0
yElF2M7x8XViVRINuYRtPJVLEx8rAIAglzzpAi4VCkztPK8uYsudctf5iW6o6NjT
GrPCLKqI/kf+hZLATin+uGGZgGIrIX3EpZVCht+fP3Ojhh2KpTErXc0ESMdlRmdh
nPQUAKYPri35umbWNGpexdEej0gOjDKqhiKnJ8wOnLr8uJ5DV1ShPdYNJDnMJH7M
J3Bhnau96AeknZuo0VcTjj4TOXqlWaM9ey7xsfvBzyAvJ7DqhRIo458XL7y0WhoW
nwq6KkIk9lah8pf8GOzYd70gMqXWtq12a5HxHNEHyWWQXXJDgVKK4Q==
=lPyF
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
