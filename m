Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSBOMN3>; Fri, 15 Feb 2002 07:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSBOMNT>; Fri, 15 Feb 2002 07:13:19 -0500
Received: from gate.perex.cz ([194.212.165.105]:46860 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S287860AbSBOMNG>;
	Fri, 15 Feb 2002 07:13:06 -0500
Date: Fri, 15 Feb 2002 13:12:55 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Jos Hulzink <josh@stack.nl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: 2.5.5-pre1: Deadlocks and ALSA driver problems
In-Reply-To: <20020215110243.U68580-100000@toad.stack.nl>
Message-ID: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1329462030-1013775175=:608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323584-1329462030-1013775175=:608
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 15 Feb 2002, Jos Hulzink wrote:

> Hi,
>
> Still fighting with the debug tools (I'm new to kernel debugging), but
> maybe this info is useful to others:
>
> 2.5.5-pre1 deadlocked completely about 7 times in 40 minutes. The Magic
> SysRq key didn't work anymore. Don't know if it is related, but after I
> recompiled the ALSA driver as modules, the system was stable for about 4
> hours. (With ALSA modules loaded, playing music, and I rebooted it myself
> afterwards.)
>
> Besides: the ALSA /proc interface is terribly broken, any cat
> /proc/asound/... results in a no such device error. The ALSA /dev entries
> return the same errors while opening them, but the OSS emulation layer
> works fine.

Attached patch for linux/sound/core/info.c fixes the problem with /proc
entries.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

--8323584-1329462030-1013775175=:608
Content-Type: TEXT/plain; name="out.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.31.0202151312550.608@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="out.txt"

SW5kZXg6IGluZm8uYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZp
bGU6IC9jdnNyb290L2Fsc2EvYWxzYS1rZXJuZWwvY29yZS9pbmZvLmMsdg0K
cmV0cmlldmluZyByZXZpc2lvbiAxLjcNCnJldHJpZXZpbmcgcmV2aXNpb24g
MS44DQpkaWZmIC11IC1yMS43IC1yMS44DQotLS0gaW5mby5jCTE0IEZlYiAy
MDAyIDE3OjQwOjMwIC0wMDAwCTEuNw0KKysrIGluZm8uYwkxNSBGZWIgMjAw
MiAxMjoxMDoyNiAtMDAwMAkxLjgNCkBAIC0yNzgsNyArMjc4LDcgQEANCiAJ
aW50IG1vZGUsIGVycjsNCiANCiAJZG93bigmaW5mb19tdXRleCk7DQotCXAg
PSAoc3RydWN0IHByb2NfZGlyX2VudHJ5ICopIGlub2RlLT51LmdlbmVyaWNf
aXA7DQorCXAgPSBQREUoaW5vZGUpOw0KIAllbnRyeSA9IHAgPT0gTlVMTCA/
IE5VTEwgOiAoc25kX2luZm9fZW50cnlfdCAqKXAtPmRhdGE7DQogCWlmIChl
bnRyeSA9PSBOVUxMKSB7DQogCQl1cCgmaW5mb19tdXRleCk7DQpAQCAtNTQx
LDcgKzU0MSw3IEBADQogc3RhdGljIGludCBzbmRfaW5mb19jYXJkX3JlYWRs
aW5rKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiAJCQkJICBjaGFyICpidWZm
ZXIsIGludCBidWZsZW4pDQogew0KLSAgICAgICAgY2hhciAqcyA9ICgoc3Ry
dWN0IHByb2NfZGlyX2VudHJ5ICopIGRlbnRyeS0+ZF9pbm9kZS0+dS5nZW5l
cmljX2lwKS0+ZGF0YTsNCisgICAgICAgIGNoYXIgKnMgPSBQREUoZGVudHJ5
LT5kX2lub2RlKS0+ZGF0YTsNCiAjaWZuZGVmIExJTlVYXzJfMg0KIAlyZXR1
cm4gdmZzX3JlYWRsaW5rKGRlbnRyeSwgYnVmZmVyLCBidWZsZW4sIHMpOw0K
ICNlbHNlDQpAQCAtNTYyLDcgKzU2Miw3IEBADQogc3RhdGljIGludCBzbmRf
aW5mb19jYXJkX2ZvbGxvd2xpbmsoc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0K
IAkJCQkgICAgc3RydWN0IG5hbWVpZGF0YSAqbmQpDQogew0KLSAgICAgICAg
Y2hhciAqcyA9ICgoc3RydWN0IHByb2NfZGlyX2VudHJ5ICopIGRlbnRyeS0+
ZF9pbm9kZS0+dS5nZW5lcmljX2lwKS0+ZGF0YTsNCisgICAgICAgIGNoYXIg
KnMgPSBQREUoZGVudHJ5LT5kX2lub2RlKS0+ZGF0YTsNCiAgICAgICAgIHJl
dHVybiB2ZnNfZm9sbG93X2xpbmsobmQsIHMpOw0KIH0NCiAjZWxzZQ0KQEAg
LTU3MCw3ICs1NzAsNyBAQA0KIAkJCQkJICAgICAgIHN0cnVjdCBkZW50cnkg
KmJhc2UsDQogCQkJCQkgICAgICAgdW5zaWduZWQgaW50IGZvbGxvdykNCiB7
DQotCWNoYXIgKnMgPSAoKHN0cnVjdCBwcm9jX2Rpcl9lbnRyeSAqKSBkZW50
cnktPmRfaW5vZGUtPnUuZ2VuZXJpY19pcCktPmRhdGE7DQorCWNoYXIgKnMg
PSBQREUoZGVudHJ5LT5kX2lub2RlKS0+ZGF0YTsNCiAJcmV0dXJuIGxvb2t1
cF9kZW50cnkocywgYmFzZSwgZm9sbG93KTsNCiB9DQogI2VuZGlmDQpAQCAt
ODQ1LDcgKzg0NSw3IEBADQogCQlyZXR1cm47DQogCX0NCiAJTU9EX0lOQ19V
U0VfQ09VTlQ7DQotCWRlID0gKHN0cnVjdCBwcm9jX2Rpcl9lbnRyeSAqKSBp
bm9kZS0+dS5nZW5lcmljX2lwOw0KKwlkZSA9IFBERShpbm9kZSk7DQogCWlm
IChkZSA9PSBOVUxMKQ0KIAkJcmV0dXJuOw0KIAllbnRyeSA9IChzbmRfaW5m
b19lbnRyeV90ICopIGRlLT5kYXRhOw0K
--8323584-1329462030-1013775175=:608--
