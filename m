Return-Path: <linux-kernel-owner+w=401wt.eu-S1761233AbWLJPeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761233AbWLJPeU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 10:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761248AbWLJPeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 10:34:20 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:55249 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761233AbWLJPeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 10:34:19 -0500
Message-ID: <457C28F8.4050409@comcast.net>
Date: Sun, 10 Dec 2006 10:34:16 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PAE/NX without performance drain?
References: <457B1F02.7030409@comcast.net> <1165743478.27217.187.camel@laptopd505.fenrus.org>
In-Reply-To: <1165743478.27217.187.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Sat, 2006-12-09 at 15:39 -0500, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Apparently (as I've been told today) using a hardware NX bit in a 32-bit
>> x86 kernel requires PAE mode.  PAE mode is enabled with HIGHMEM64, which
>> is (apparently) extremely slow.
> 
> 
> it's not extremely slow. 
> 
> there is a minor performance delta, sure, but to be honest that's a
> benchmark thing more than a real life thing.
> 
> What did your measurements show that the slowdown was? And how did you
> measure this?

I didn't measure, I was told by various people on IRC.  Also Google has
some misleading facts:

 - Someone mentioned that HIGHMEM64G + 4G split costs 10%-30%.  I
   immediately took that as "4G split might be friggin' expensive."

 - In some discussions Ingo mentioned HIGHMEM64G re RT preemption being
   a huge performance delta; but I haven't found evidence that this
   isn't a bug in RT.

Too bad PAE can't be detected at boot time; someone else mentioned that
some recent Pentium M laptops (and anything older than PPro) don't boot
if PAE is on.  Making 2 copies of the functions would be a pain in the
ass; and using indirect addressing and function pointers would be...
slow.  In performance critical areas.

I want my hardware NX bit working in Ubuntu without having to recompile
my kernel dammit.  How do I swing this one past them?  The performance I
can argue; breaking 586 and some random laptops (I've been contacted by
someone who has several of these Pentium-M machines that die on PAE) I
can't do.

> 
> 
> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXwo9ws1xW0HCTEFAQK7DA/+KOZavRjhhp0N8k+cj2E0YTT5f1HbV0wE
mi0QqOwhR6VFg/8M+HGU5ytnmdXnNm5TyyTvxHfgEFaWpwMxWhAT0KZgP5twGc/9
f2uY9s600nvmDXnh9zKFsFBmIgJqdg++01cY9C6O2cl7xfTTvrzVXllZOBMtvKxh
KmkHr0VVNhs2V4EYlEhKhMh2OAhYFtnUdd2VyV4d3snn4Y/Y/IneMM0GxULjGwg5
V7ATdJgs+s02iT8cRGFKbbn3H+0DtIxolIhlkvukPy0xfECtx/92HguLkLfq4o6I
rRyP1n42vkY2wmKFtgnYU9CXBmd+1/GOmiVXk77+lID9xDQpWa5e3j4uB8o/StYv
6NMfj66Sc5yq/4+9lBB7awPA5gZkgBmYcTl4bvM5+FVxkr1pREUXzD589y9AEAoa
fCVv0DXTZwDjYZBY9uFRZyRe0UVgPFwyBqq6S5QISXge242spGo6G9QJKj25vsMY
JYdJb6f0EFzqwcFhYy+pp5s2NAId1lPT6SxhPq9aJ36enI8j4vJHPHSM8yBdVGSP
g8OzFLb9EYTKvSzdTN1JwAMkGvwGKcfY+tEIEUlTEb0wqwEfA3rClWdb4ikEBl5D
G2kjPqlGCdOXjIkijSzu8d6w7jPa+/EhdWRnBxuP/H7iKLWJoxaMqOR27nVx7/Fo
OiJeilQNMMA=
=+GiD
-----END PGP SIGNATURE-----
