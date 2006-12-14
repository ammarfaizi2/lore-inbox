Return-Path: <linux-kernel-owner+w=401wt.eu-S1751187AbWLNEf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWLNEf0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 23:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWLNEf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 23:35:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:40086 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbWLNEfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 23:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=K8dSOlkGw+cWuzLqqUuAOO1yX+1zv8ZSTC+SxFopycaZOoNoyflN8e30en+98h3sziOxu5YwNDFoB3f7/VdqpzNqj5ABNfxGtxnxKJheFbibdwJ6FIqtgc7m4rQ9QdAizwhGHMh+yoPDVxROociJbM60kNtLqbeMRDCfTZVenNo=
Message-ID: <5b8e20700612132035w2ad90000wcaca60be5d93277d@mail.gmail.com>
Date: Wed, 13 Dec 2006 23:35:23 -0500
From: "Michael Bommarito" <michael.bommarito@gmail.com>
To: "Mike Galbraith" <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git19] BUG due to bad argument to ieee80211softmac_assoc_work
In-Reply-To: <1166070494.5853.0.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_65465_15737798.1166070923846"
References: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>
	 <1166070494.5853.0.camel@Homer.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_65465_15737798.1166070923846
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry, realized I might not have been clear as to what I meant!  The
patch was attached to the bugzilla entry, but I'll attach it here as
well.  My description of the patch itself was really as complicated as
it gets too (just two lines, switch (void*)mac to
&mac->assoc.work.work in
net/ieee80211/softmac/ieee80211softmac_assoc.c), just a small bug
while somebody was rushing through the work/delayed_work changes.

-Mike

On 12/13/06, Mike Galbraith <efault@gmx.de> wrote:
> On Wed, 2006-12-13 at 13:17 -0500, Michael Bommarito wrote:
> > This didn't get much attention on bugzilla and I figured it was
> > important enough to forward along to the whole list since it's been
> > lingering around in ieee80211-softmac since 19-git5 at least.
> > http://bugzilla.kernel.org/show_bug.cgi?id=7657
> >
> > Somebody was passing the whole mac device structure to
> > ieee80211softmac_assoc_work instead of just the assocation work, which
> > lead to much death and locking.
> >
> > Attached is a patch that fixes this (the actual change is two lines
> > but context provided in patch for review).  The dmesg containing call
> > trace is attached to the bugzilla entry above.
>
> -ENOPATCH :)
>
>

------=_Part_65465_15737798.1166070923846
Content-Type: application/octet-stream; 
	name=patch-ieee80211softmac_assoc_work
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evoofzsz
Content-Disposition: attachment; filename="patch-ieee80211softmac_assoc_work"

LS0tIG5ldC9pZWVlODAyMTEvc29mdG1hYy9pZWVlODAyMTFzb2Z0bWFjX2Fzc29jLmMJMjAwNi0x
Mi0xMyAxMToyMzowMy4wMDAwMDAwMDAgLTA1MDAKKysrIG5ldC9pZWVlODAyMTEvc29mdG1hYy9p
ZWVlODAyMTFzb2Z0bWFjX2Fzc29jLmMJMjAwNi0xMi0xMyAxMToyNDoyNi4wMDAwMDAwMDAgLTA1
MDAKQEAgLTE2Nyw3ICsxNjcsNyBAQAogaWVlZTgwMjExc29mdG1hY19hc3NvY19ub3RpZnlfc2Nh
bihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgZXZlbnRfdHlwZSwgdm9pZCAqY29udGV4dCkK
IHsKIAlzdHJ1Y3QgaWVlZTgwMjExc29mdG1hY19kZXZpY2UgKm1hYyA9IGllZWU4MDIxMV9wcml2
KGRldik7Ci0JaWVlZTgwMjExc29mdG1hY19hc3NvY193b3JrKCh2b2lkKiltYWMpOworCWllZWU4
MDIxMXNvZnRtYWNfYXNzb2Nfd29yaygmbWFjLT5hc3NvY2luZm8ud29yay53b3JrKTsKIH0KIAog
c3RhdGljIHZvaWQKQEAgLTE3Nyw3ICsxNzcsNyBAQAogCiAJc3dpdGNoIChldmVudF90eXBlKSB7
CiAJY2FzZSBJRUVFODAyMTFTT0ZUTUFDX0VWRU5UX0FVVEhFTlRJQ0FURUQ6Ci0JCWllZWU4MDIx
MXNvZnRtYWNfYXNzb2Nfd29yaygodm9pZCopbWFjKTsKKwkgICAgICAgIGllZWU4MDIxMXNvZnRt
YWNfYXNzb2Nfd29yaygmbWFjLT5hc3NvY2luZm8ud29yay53b3JrKTsKIAkJYnJlYWs7CiAJY2Fz
ZSBJRUVFODAyMTFTT0ZUTUFDX0VWRU5UX0FVVEhfRkFJTEVEOgogCWNhc2UgSUVFRTgwMjExU09G
VE1BQ19FVkVOVF9BVVRIX1RJTUVPVVQ6Cg==
------=_Part_65465_15737798.1166070923846--
