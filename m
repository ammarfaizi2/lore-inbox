Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTD1FBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 01:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTD1FBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 01:01:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:26934 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263449AbTD1FBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 01:01:05 -0400
Message-Id: <5.2.0.9.2.20030428065930.00caaf88@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 28 Apr 2003 07:17:47 +0200
To: "Martin J. Bligh" <mbligh@aracnet.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Houston, I think we have a problem
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <28750000.1051454510@[10.10.2.4]>
References: <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
 <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_13034671==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_13034671==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 07:41 AM 4/27/2003 -0700, Martin J. Bligh wrote:
> > To reproduce this 100% of the time, simply compile virgin 2.5.68
> > up/preempt, reduce your ram to 128mb, and using gcc-2.95.3 as to not
> > overload the vm, run a make -j30 bzImage in an ext3 partition on a P3/500
> > single ide disk box.  No, you don't really need to meet all of those
> > restrictions... you'll see the problem on a big hairy chested box as
> > well, just not as bad as I see it on my little box.  The first symptom of
> > the problem you will notice is a complete lack of swap activity along
> > with highly improbable quantities of unused ram were all those hungry
> > cc1's getting regular CPU feedings.
>
>Yes, that's why I don't use ext3 ;-) It's known broken, akpm is fixing it.

He might be interested in the attached then.

(It illustrates the one wakeup thingie I'm muttering and mumbling about 
nicely too.  Both of the players are going to have 3 seconds to ruin 
everyone else's day.  This is why I turned the problem upside-down in my 
experiment... if your shell and it's kids aren't maxed out when this 
happens, interactivity turns el-stinko)

I'll go back to my corner now and play quietly ;-)

         -Mike 
--=====================_13034671==_
Content-Type: text/plain; name="xx.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.txt"

NjYyMzoyMSBzdGFydmVkIDEgc2VjcyBieSA2NjE5OjIxIHdobyBsYXN0IHJhbiAyMTcyIHRpY2tz
IGFnby4Kc2VtYXBob3JlIGRvd25lZCBhdCBmcy9uYW1laS5jOjEyNDkuCgo2NjIzOjIwIHN0YXJ2
ZWQgMiBzZWNzIGJ5IDY2MTk6MjEgd2hvIGxhc3QgcmFuIDMxNzIgdGlja3MgYWdvLgpzZW1hcGhv
cmUgZG93bmVkIGF0IGZzL25hbWVpLmM6MTI0OS4KCjY2MjM6MTkgc3RhcnZlZCAzIHNlY3MgYnkg
NjYxOToyMSB3aG8gbGFzdCByYW4gNDE3MiB0aWNrcyBhZ28uCnNlbWFwaG9yZSBkb3duZWQgYXQg
ZnMvbmFtZWkuYzoxMjQ5LgoKNjYyMzoxOCBzdGFydmVkIDQgc2VjcyBieSA2NjE5OjIxIHdobyBs
YXN0IHJhbiA1MTcyIHRpY2tzIGFnby4Kc2VtYXBob3JlIGRvd25lZCBhdCBmcy9uYW1laS5jOjEy
NDkuCgo2NjIzOjE3IHN0YXJ2ZWQgNSBzZWNzIGJ5IDY2MTk6MjEgd2hvIGxhc3QgcmFuIDYxODMg
dGlja3MgYWdvLgpzZW1hcGhvcmUgZG93bmVkIGF0IGZzL25hbWVpLmM6MTI0OS4KCjY2MjM6MTYg
c3RhcnZlZCA2IHNlY3MgYnkgNjYxOToyMSB3aG8gbGFzdCByYW4gNzIwMyB0aWNrcyBhZ28uCnNl
bWFwaG9yZSBkb3duZWQgYXQgZnMvbmFtZWkuYzoxMjQ5LgoKNjYyMzoxNSBzdGFydmVkIDcgc2Vj
cyBieSA2NjE5OjIxIHdobyBsYXN0IHJhbiA4MjIzIHRpY2tzIGFnby4KYXMgICAgICAgICAgICBE
IDAwMDAwMjg2IDQyNjkzOTM2ODAgIDY2MTkgICA2NDc2ICAgICAgICAgICAgICAgICAgICAgKE5P
VExCKQpDYWxsIFRyYWNlOgogWzxjMDExNjMxNz5dIHNsZWVwX29uKzB4NWIvMHg4NAogWzxjMDEx
NWY5MD5dIGRlZmF1bHRfd2FrZV9mdW5jdGlvbisweDAvMHgxYwogWzxjMDE4MjQzMD5dIHN0YXJ0
X3RoaXNfaGFuZGxlKzB4MTQwLzB4MjM0CiBbPGMwMTgyNWZmPl0gam91cm5hbF9zdGFydCsweDkz
LzB4YzgKIFs8YzAxN2Q2NGE+XSBleHQzX2pvdXJuYWxfc3RhcnQrMHgyYS8weDRjCiBbPGMwMTdi
ZTRkPl0gZXh0M19jcmVhdGUrMHgzMS8weDE5OAogWzxjMDE1MDIyZD5dIHZmc19jcmVhdGUrMHhh
ZC8weGQ0CiBbPGMwMTUwNWViPl0gb3Blbl9uYW1laSsweDE5Ny8weDQ4MAogWzxjMDE0MmQyNj5d
IGZpbHBfb3BlbisweDNhLzB4NWMKIFs8YzAxNDMxNGY+XSBzeXNfb3BlbisweDM3LzB4NzQKIFs8
YzAxMDhlYmI+XSBzeXNjYWxsX2NhbGwrMHg3LzB4YgoKc2VtYXBob3JlIGRvd25lZCBhdCBmcy9u
YW1laS5jOjEyNDkuCgo2NjIzOjE1IHN0YXJ2ZWQgOCBzZWNzIGJ5IDY2MTk6MTUgd2hvIGxhc3Qg
cmFuIDU0NyB0aWNrcyBhZ28uCmFzICAgICAgICAgICAgRCAwMDBCREUxMSA0MjY5MzkzNjgwICA2
NjE5ICAgNjQ3NiAgICAgICAgICAgICAgICAgICAgIChOT1RMQikKQ2FsbCBUcmFjZToKIFs8YzAx
MWZkMWE+XSBzY2hlZHVsZV90aW1lb3V0KzB4N2UvMHhhOAogWzxjMDExZmM4Yz5dIHByb2Nlc3Nf
dGltZW91dCsweDAvMHgxMAogWzxjMDEwN2QwYT5dIF9fZG93bisweDllLzB4MWE4CiBbPGMwMTE1
ZjkwPl0gZGVmYXVsdF93YWtlX2Z1bmN0aW9uKzB4MC8weDFjCiBbPGMwMTA4MDJiPl0gX19kb3du
X2ZhaWxlZCsweGIvMHgxNAogWzxjMDE4NDRjYT5dIC50ZXh0LmxvY2sudHJhbnNhY3Rpb24rMHg1
LzB4MTViCiBbPGMwMTgyNWZmPl0gam91cm5hbF9zdGFydCsweDkzLzB4YzgKIFs8YzAxN2Q2NGE+
XSBleHQzX2pvdXJuYWxfc3RhcnQrMHgyYS8weDRjCiBbPGMwMTdiZTRkPl0gZXh0M19jcmVhdGUr
MHgzMS8weDE5OAogWzxjMDE1MDIyZD5dIHZmc19jcmVhdGUrMHhhZC8weGQ0CiBbPGMwMTUwNWVi
Pl0gb3Blbl9uYW1laSsweDE5Ny8weDQ4MAogWzxjMDE0MmQyNj5dIGZpbHBfb3BlbisweDNhLzB4
NWMKIFs8YzAxNDMxNGY+XSBzeXNfb3BlbisweDM3LzB4NzQKIFs8YzAxMDhlYmI+XSBzeXNjYWxs
X2NhbGwrMHg3LzB4YgoKc2VtYXBob3JlIGRvd25lZCBhdCBmcy9uYW1laS5jOjEyNDkuCgo=
--=====================_13034671==_--

