Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756168AbWKRDXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbWKRDXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 22:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbWKRDXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 22:23:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:30773 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1756168AbWKRDXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 22:23:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=T2HXHZg8JkHOdNhTIE+PibbcWN0CFJshZr8aAnmBfYnqtS37dK0ap5iXLHyUK924A8eU8qlK9SzJ034JI+3BSBO4abCzG0T0GepSQ8hST2kIHzcrgPE3e/nV9KH/kcDGvLlWwd+r9BrJDVs8EZQfbyPxqE+QD/JwekXTdAMFwdU=
Message-ID: <52e895540611171923p425e30feh832c693d7529b6a7@mail.gmail.com>
Date: Sat, 18 Nov 2006 04:23:06 +0100
From: "Pavol Gono" <palo.gono@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: tests of kernel modules
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_63845_23759633.1163820186039"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_63845_23759633.1163820186039
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

After resolving http://bugzilla.kernel.org/show_bug.cgi?id=7481
I was thinking about possibilities how to prevent such bugs with
testing. Usually just few insmods and rmmods show, whether the
initialization and cleanup code of module is ok or not.

I created a script which do the automatic job of finding all modules
and inserting/removing them (see attachment). On my Lifebook E8110,
kernel 2.6.18.2, the following modules were problematic:
arptable_filter pktgen rfcomm rpcsec_gss_krb5 sdhci xt_NFQUEUE
Kernel logs usually say "BUG: unable to handle kernel paging request
at virtual address ..." or "BUG: unable to handle kernel NULL pointer
dereference at virtual address 00000000".

When trying knoppix 5.0.1, my script causes total freeze quickly.
Is it worth to report each buggy module to bugzilla? Reproducing is
quite simple, effects common. People just usually don't use many
insmod-s & rmmod-s in normal life...

Palo

------=_Part_63845_23759633.1163820186039
Content-Type: application/x-shellscript; name="test_modules"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test_modules"
X-Attachment-Id: file0

IyEvYmluL3NoCiMKIyBUaGlzIHNjcmlwdCB0cmllcyB0byBkbyBpbnNtb2QgJiBybW1vZCBmb3Ig
ZWFjaCBrZXJuZWwgbW9kdWxlCiMgbXVsdGlwbGUgdGltZXMuIFNjcmlwdCBjYW4gaGVscCB0byBk
ZXRlY3QgYnVnZ3kgaW5pdGlhbGl6YXRpb24gYW5kCiMgY2xlYW51cCBjb2RlLiBBZnRlciBydW5u
aW5nLCBtYW4gc2hvdWxkIGNoZWNrIGtlcm5lbCBsb2cgbWVzc2FnZXMuCiMKIyBTaWRlIGVmZmVj
dHM6CiMgLSBkdXJpbmcgcnVubmluZyBzb21lIGltcG9ydGFudCBtb2R1bGVzIGNhbiBiZSB1bmxv
YWRlZCB0ZW1wb3JhcmlseQojICAgKHNlZSBCTEFDS0xJU1RfTU9EVUxFUykKIyAtIHBvc3NpYmxl
IGNyYXNoIG9yIG1hbGZ1bmN0aW9uIG9mIG1hY2hpbmUKIwojIFdyaXR0ZW4gYnkgUGF2b2wgR29u
bwojIEZyZWUgdG8gdXNlIGFuZCBtb2RpZnkKCgojIE51bWJlciBvZiBpbnNtb2QtcyBhbmQgcm1t
b2QtcyBmb3IgZWFjaCBtb2R1bGUKTlVNX0xPQURJTkdTPTEwCgojIFBhdGggd2hlcmUgeW91ciBt
b2R1bGVzIHJlc2lkZSAocGF0aCB3aWxsIGJlIHNlYXJjaGVkIHJlY3Vyc2l2ZWx5KQpNT0RVTEVT
X1BBVEg9Ii9saWIvbW9kdWxlcy8kKHVuYW1lIC1yKSIKCiMgTW9kdWxlcyB3aGljaCBzaGFsbCBu
b3QgYmUgdGVzdGVkLCBzZXBhcmF0ZWQgYnkgc3BhY2VzCiMgKHVzZSBvbmx5IHVuZGVyc2NvcmVz
ICdfJyBpbiBtb2R1bGUgbmFtZXMpCkJMQUNLTElTVF9NT0RVTEVTPSJhcnB0YWJsZV9maWx0ZXIg
YXRrYmQgcGt0Z2VuIHJmY29tbSBycGNzZWNfZ3NzX2tyYjUgc2N0cCBzZGhjaSB4dF9ORlFVRVVF
IgoKIyBNb2R1bGVzIHdoaWNoIHNoYWxsIHJlbWFpbiBsb2FkZWQgYWZ0ZXIgdGVzdApMT0FERURf
TU9EVUxFUz0iJChsc21vZCB8IGF3ayAnTlIgPiAxIHtwcmludCAkMX0nKSIKCgpmaW5kICIkTU9E
VUxFU19QQVRIIiAtdHlwZSBmIC1uYW1lICcqLmtvJyAtcHJpbnRmICIlZlxuIiB8IHRyIC0gXyB8
IFwKd2hpbGUgcmVhZCBNT0RVTEVfRklMRSA7IGRvCiAgIE1PRFVMRV9OQU1FPSIke01PRFVMRV9G
SUxFJS5rb30iCiAgIEJMQUNLTElTVEVEPTAKICAgZm9yIEkgaW4gJEJMQUNLTElTVF9NT0RVTEVT
IDsgZG8KICAgICAgaWYgWyAkSSA9ICIkTU9EVUxFX05BTUUiIF0gOyB0aGVuCiAgICAgICAgIEJM
QUNLTElTVEVEPTEKICAgICAgICAgYnJlYWsKICAgICAgZmkKICAgZG9uZQogICBpZiBbICRCTEFD
S0xJU1RFRCA9IDEgXSA7IHRoZW4KICAgICAgY29udGludWUKICAgZmkKICAgZWNobyAtbiAiVGVz
dGluZyBtb2R1bGUgJE1PRFVMRV9OQU1FICIKICAgST0xCiAgIHdoaWxlIFsgJEkgLWxlICIkTlVN
X0xPQURJTkdTIiBdIDsgZG8KICAgICAgbW9kcHJvYmUgIiRNT0RVTEVfTkFNRSIgPi9kZXYvbnVs
bCAyPiYxCiAgICAgIGlmIFsgJD8gPSAwIF0gOyB0aGVuCiAgICAgICAgIGVjaG8gLW4gLgogICAg
ICBlbHNlCiAgICAgICAgIGVjaG8gLW4gSQogICAgICBmaQogICAgICBybW1vZCAiJE1PRFVMRV9O
QU1FIiA+L2Rldi9udWxsIDI+JjEKICAgICAgaWYgWyAkPyA9IDAgXSA7IHRoZW4KICAgICAgICAg
ZWNobyAtbiAuCiAgICAgIGVsc2UKICAgICAgICAgZWNobyAtbiBSCiAgICAgIGZpCiAgICAgIEk9
JCgoJEkgKyAxKSkKICAgZG9uZQogICBUT19CRV9MT0FERUQ9MAogICBmb3IgSSBpbiAkTE9BREVE
X01PRFVMRVMgOyBkbwogICAgICBpZiBbICRJID0gIiRNT0RVTEVfTkFNRSIgXSA7IHRoZW4KICAg
ICAgICAgVE9fQkVfTE9BREVEPTEKICAgICAgICAgYnJlYWsKICAgICAgZmkKICAgZG9uZQogICBp
ZiBbICRUT19CRV9MT0FERUQgPSAxIF0gOyB0aGVuCiAgICAgIG1vZHByb2JlICIkTU9EVUxFX05B
TUUiID4vZGV2L251bGwgMj4mMQogICBmaQogICBlY2hvCmRvbmUKCiMgVHJ5aW5nIHRvIHVubG9h
ZCBhbGwgbW9kdWxlcyB3aGljaCBoYXZlbid0IGJlZW4gbG9hZGVkCmVjaG8gLW4gIlVubG9hZGlu
ZyBuZWVkbGVzcyBtb2R1bGVzICIKZm9yIGkgaW4gMSAyIDMgNCA7IGRvCiAgIGxzbW9kIHwgYXdr
ICdOUiA+IDEge3ByaW50ICQxfScgfCBcCiAgIHdoaWxlIHJlYWQgTU9EVUxFX05BTUUgOyBkbwog
ICAgICBUT19CRV9VTkxPQURFRD0xCiAgICAgIGZvciBJIGluICRMT0FERURfTU9EVUxFUyA7IGRv
CiAgICAgICAgIGlmIFsgJEkgPSAiJE1PRFVMRV9OQU1FIiBdIDsgdGhlbgogICAgICAgICAgICBU
T19CRV9VTkxPQURFRD0wCiAgICAgICAgICAgIGJyZWFrCiAgICAgICAgIGZpCiAgICAgIGRvbmUK
ICAgICAgaWYgWyAkVE9fQkVfVU5MT0FERUQgPSAxIF0gOyB0aGVuCiAgICAgICAgIG1vZHByb2Jl
IC1yICIkTU9EVUxFX05BTUUiID4vZGV2L251bGwgMj4mMQogICAgICAgICBpZiBbICQ/ID0gMCBd
IDsgdGhlbgogICAgICAgICAgICBlY2hvIC1uIC4KICAgICAgICAgZmkKICAgICAgZmkKICAgZG9u
ZQpkb25lCmVjaG8KCiMgU29tZSBtaXNzaW5nIGNsZWFudXBzIGluIG1vZHVsZSBjb2RlIGNvdWxk
IGdlbmVyYXRlIG9vcHMKZWNobyAiVGVzdGluZyAvc3lzIHNlYXJjaGFiaWxpdHkiCmZpbmQgL3N5
cyA+L2Rldi9udWxsIDI+JjEKZWNobyAiVGVzdGluZyAvcHJvYyBzZWFyY2hhYmlsaXR5IgpmaW5k
IC9wcm9jID4vZGV2L251bGwgMj4mMQoKZWNobyAiZG9uZSIK
------=_Part_63845_23759633.1163820186039--
