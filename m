Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270195AbRHSHQq>; Sun, 19 Aug 2001 03:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRHSHQh>; Sun, 19 Aug 2001 03:16:37 -0400
Received: from horsea.3ti.be ([212.204.244.41]:19985 "EHLO horsea.3ti.be")
	by vger.kernel.org with ESMTP id <S270195AbRHSHQ2>;
	Sun, 19 Aug 2001 03:16:28 -0400
Date: Sun, 19 Aug 2001 09:16:37 +0200 (CEST)
From: Dag Wieers <dag@wieers.com>
X-X-Sender: <dag@horsea.3ti.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Patch to scripts/mkspec
Message-ID: <Pine.LNX.4.33.0108190906050.9367-200000@horsea.3ti.be>
User-Agent: Mutt/1.2.5i
X-Mailer: Evolution 0.10 (Tasmanian Devil)
Organization: 3TI Web Hosting Services
X-Extra: We know linux is the best. It can do infinitie loops in five seconds. - Linus Torvalds
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-858510860-1949473437-997927830=:9367"
Content-ID: <Pine.LNX.4.33.0108181717201.9367@horsea.3ti.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---858510860-1949473437-997927830=:9367
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.33.0108181717202.9367@horsea.3ti.be>

Hey,

I've changed my patch a bit.

  + tarball is called:	kernel-2.4.8-ac7.tar.gz
      package:		kernel-2.4.8_ac7-15.i386.rpm
      kernel image:	kernel-2.4.8-ac7-15
      kernel itself:	kernel-2.4.8-ac7

      (I rather have the kernel named kernel-2.4.8-ac7-15 too so modules
       don't conflict if you've got several builds from the same tree)

  + seperate documentation package
      (I rather put this in a seperate spec-file and add a make doc-rpm)

  + .config is added to the package

  + use of macros (which is allowed since rpm v3 I think)
      Alan, I know you disapprove this, but I'm not sure it matters
      Documentation of RPM is bad though.

  + package now is eg. i686 if kernel is built for i686


Advantages:

  + you can install kernels that only differ in release-nr (except for modules)
  + packages build on the same tree (for different machines) have a unique
      name (otherwise it is a sysadmin hell)


Todo:

  + make it not i386-specific (as we use bzImage, right ?)
  + if the kernel is SMP, the package should say so
  + add the .version in the Makefile to KERNELRELEASE (so that the tarball
      and modules-dir have a unique name for each build)
  + build the DocBook-stuff for the documentation (although you need more
      dependencies, so moving it to a seperate spec-file makes sense)
  + add builddependencies (although this could be a distro-nightmare)


Could you give me feedback (as I didn't get a reply on my previous mail).

Thanks in advance,

--   dag wieers,  dag@wieers.com,  http://dag.wieers.com/   --
«Onder voorbehoud van hetgeen niet uitdrukkelijk wordt erkend»

---858510860-1949473437-997927830=:9367
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch-kernel-rpm-3
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108190916370.9367@horsea.3ti.be>
Content-Description: 
Content-Disposition: attachment; filename=patch-kernel-rpm-3

LS0tIGxpbnV4L01ha2VmaWxlLm9yaWcJU2F0IEF1ZyAxOCAxNzowOToyMyAy
MDAxDQorKysgbGludXgvTWFrZWZpbGUJU2F0IEF1ZyAxOCAxODoyNDozOSAy
MDAxDQpAQCAtNSw4ICs1LDYgQEANCiANCiBLRVJORUxSRUxFQVNFPSQoVkVS
U0lPTikuJChQQVRDSExFVkVMKS4kKFNVQkxFVkVMKSQoRVhUUkFWRVJTSU9O
KQ0KIA0KLUtFUk5FTFBBVEg9a2VybmVsLSQoc2hlbGwgZWNobyAkKEtFUk5F
TFJFTEVBU0UpIHwgc2VkIC1lICJzLy0vLyIpDQotDQogIyBTVUJBUkNIIHRl
bGxzIHRoZSB1c2VybW9kZSBidWlsZCB3aGF0IHRoZSB1bmRlcmx5aW5nIGFy
Y2ggaXMuICBUaGF0IGlzIHNldA0KICMgZmlyc3QsIGFuZCBpZiBhIHVzZXJt
b2RlIGJ1aWxkIGlzIGhhcHBlbmluZywgdGhlICJBUkNIPXVtIiBvbiB0aGUg
Y29tbWFuZA0KICMgbGluZSBvdmVycmlkZXMgdGhlIHNldHRpbmcgb2YgQVJD
SCBiZWxvdy4gIElmIGEgbmF0aXZlIGJ1aWxkIGlzIGhhcHBlbmluZywNCkBA
IC01MzksNiArNTM3LDcgQEANCiAJZmluZCAuIFwoIC1zaXplIDAgLW8gLW5h
bWUgLmRlcGVuZCAtbyAtbmFtZSAuaGRlcGVuZCBcKSAtdHlwZSBmIC1wcmlu
dCB8IHhhcmdzIHJtIC1mDQogCXNldCAtZTsgXA0KIAljZCAkKFRPUERJUikv
Li4gOyBcDQotCWxuIC1zZiAkKFRPUERJUikgJChLRVJORUxQQVRIKSA7IFwN
Ci0JdGFyIGN2ZnogJChLRVJORUxQQVRIKS50YXIuZ3ogJChLRVJORUxQQVRI
KS8uIDsgXA0KLQlycG0gLXRhICQoVE9QRElSKS8uLi8kKEtFUk5FTFBBVEgp
LnRhci5neg0KKwlsbiAtc2YgJChUT1BESVIpIGtlcm5lbC0kKEtFUk5FTFJF
TEVBU0UpIDsgXA0KKwl0YXIgY2Z6IGtlcm5lbC0kKEtFUk5FTFJFTEVBU0Up
LnRhci5neiBrZXJuZWwtJChLRVJORUxSRUxFQVNFKS8uDQorCXNldCAtZTsg
XA0KKwlycG0gLXRiICQoVE9QRElSKS8uLi9rZXJuZWwtJChLRVJORUxSRUxF
QVNFKS50YXIuZ3oNCi0tLSBsaW51eC9zY3JpcHRzL21rc3BlYy5vcmlnCVNh
dCBBdWcgMTggMTc6MDk6MTggMjAwMQ0KKysrIGxpbnV4L3NjcmlwdHMvbWtz
cGVjCVN1biBBdWcgMTkgMDg6MjE6MTUgMjAwMQ0KQEAgLTYsNDEgKzYsNjIg
QEANCiAjCVRoZSBvbmx5IGdvdGhpYyBiaXQgaGVyZSBpcyByZWRlZmluaW5n
IGluc3RhbGxfcG9zdCB0byBhdm9pZCANCiAjCXN0cmlwcGluZyB0aGUgc3lt
Ym9scyBmcm9tIGZpbGVzIGluIHRoZSBrZXJuZWwgd2hpY2ggd2Ugd2FudA0K
ICMNCisjCVRPRE86DQorIwkJKyBBZGQgLXNtcCB0byBwYWNrYWdlbmFtZSBp
ZiBTTVANCisjCQkrIE1ha2UgaXQgbm9uIGkzODYtc3BlY2lmaWMNCisjDQor
ZWNobyAiJWRlZmluZSBfX3NwZWNfaW5zdGFsbF9wb3N0IC91c3IvbGliL3Jw
bS9icnAtY29tcHJlc3MgfHwgOiINCitlY2hvIC1uICIlZGVmaW5lIGFyY2gg
Ig0KK2VjaG8gJENGTEFHUyB8IHNlZCAicy9eLipbOnNwYWNlOl1cPy1tYXJj
aD1cKC4qXClbOnNwYWNlOl1cPy4qJC9cMS8iDQorZWNobw0KIGVjaG8gIk5h
bWU6IGtlcm5lbCINCiBlY2hvICJTdW1tYXJ5OiBUaGUgTGludXggS2VybmVs
Ig0KLWVjaG8gIlZlcnNpb246ICIkVkVSU0lPTi4kUEFUQ0hMRVZFTC4kU1VC
TEVWRUwkRVhUUkFWRVJTSU9OIHwgc2VkIC1lICJzLy0vLyINCitlY2hvICJW
ZXJzaW9uOiAiJFZFUlNJT04uJFBBVENITEVWRUwuJFNVQkxFVkVMJEVYVFJB
VkVSU0lPTiB8IHNlZCAtZSAicy8tL18vIg0KIGVjaG8gLW4gIlJlbGVhc2U6
ICINCiBjYXQgLnZlcnNpb24NCiBlY2hvICJMaWNlbnNlOiBHUEwiDQogZWNo
byAiR3JvdXA6IFN5c3RlbSBFbnZpcm9ubWVudC9LZXJuZWwiDQogZWNobyAi
VmVuZG9yOiBUaGUgTGludXggQ29tbXVuaXR5Ig0KLWVjaG8gIlVSTDogaHR0
cDovL3d3dy5rZXJuZWwub3JnIg0KLWVjaG8gLW4gIlNvdXJjZToga2VybmVs
LSRWRVJTSU9OLiRQQVRDSExFVkVMLiRTVUJMRVZFTCINCi1lY2hvICIkRVhU
UkFWRVJTSU9OLnRhci5neiIgfCBzZWQgLWUgInMvLS8vIg0KLWVjaG8gIkJ1
aWxkUm9vdDogL3Zhci90bXAvJXtuYW1lfS0le1BBQ0tBR0VfVkVSU0lPTn0t
cm9vdCINCi1lY2hvICIlZGVmaW5lIF9fc3BlY19pbnN0YWxsX3Bvc3QgL3Vz
ci9saWIvcnBtL2JycC1jb21wcmVzcyB8fCA6Ig0KLWVjaG8gIiINCitlY2hv
ICJVUkw6IGh0dHA6Ly93d3cua2VybmVsLm9yZy8iDQorZWNobyAiU291cmNl
OiBrZXJuZWwtJFZFUlNJT04uJFBBVENITEVWRUwuJFNVQkxFVkVMJEVYVFJB
VkVSU0lPTi50YXIuZ3oiDQorZWNobyAiQnVpbGRSb290OiAle190bXBwYXRo
fS8le25hbWV9LSV7dmVyc2lvbn0iDQorZWNobyAiQnVpbGRBcmNoOiAle2Fy
Y2h9Ig0KK2VjaG8gIlJlcXVpcmVzOiBiaW51dGlscyINCitlY2hvDQogZWNo
byAiJWRlc2NyaXB0aW9uIg0KIGVjaG8gIlRoZSBMaW51eCBLZXJuZWwsIHRo
ZSBvcGVyYXRpbmcgc3lzdGVtIGNvcmUgaXRzZWxmIg0KLWVjaG8gIiINCitl
Y2hvDQorZWNobyAiJXBhY2thZ2UgZG9jIg0KK2VjaG8gIlN1bW1hcnk6IFRo
ZSBMaW51eCBLZXJuZWwgZG9jdW1lbnRhdGlvbiINCitlY2hvICJHcm91cDog
RG9jdW1lbnRhdGlvbiINCitlY2hvICJCdWlsZEFyY2g6IG5vYXJjaCINCitl
Y2hvDQorZWNobyAiJWRlc2NyaXB0aW9uIGRvYyINCitlY2hvICJUaGUgTGlu
dXggS2VybmVsIGRvY3VtZW50YXRpb24uIg0KK2VjaG8NCiBlY2hvICIlcHJl
cCINCi1lY2hvICIlc2V0dXAgLXEiDQotZWNobyAiIg0KK2VjaG8gIiVzZXR1
cCAtcSAtbiBrZXJuZWwtJFZFUlNJT04uJFBBVENITEVWRUwuJFNVQkxFVkVM
JEVYVFJBVkVSU0lPTiINCitlY2hvDQogZWNobyAiJWJ1aWxkIg0KIGVjaG8g
Im1ha2Ugb2xkY29uZmlnIGRlcCBjbGVhbiBiekltYWdlIG1vZHVsZXMiDQot
ZWNobyAiIg0KK2VjaG8NCiBlY2hvICIlaW5zdGFsbCINCi1lY2hvICdta2Rp
ciAtcCAkUlBNX0JVSUxEX1JPT1QvYm9vdCAkUlBNX0JVSUxEX1JPT1QvbGli
ICRSUE1fQlVJTERfUk9PVC9saWIvbW9kdWxlcycNCi1lY2hvICdJTlNUQUxM
X01PRF9QQVRIPSRSUE1fQlVJTERfUk9PVCBtYWtlIG1vZHVsZXNfaW5zdGFs
bCcNCi1lY2hvICdjcCBhcmNoL2kzODYvYm9vdC9iekltYWdlICRSUE1fQlVJ
TERfUk9PVCciL2Jvb3Qvdm1saW51ei0kVkVSU0lPTi4kUEFUQ0hMRVZFTC4k
U1VCTEVWRUwkRVhUUkFWRVJTSU9OIg0KLWVjaG8gJ2NwIFN5c3RlbS5tYXAg
JFJQTV9CVUlMRF9ST09UJyIvYm9vdC9TeXN0ZW0ubWFwLSRWRVJTSU9OLiRQ
QVRDSExFVkVMLiRTVUJMRVZFTCRFWFRSQVZFUlNJT04iDQotZWNobyAiIg0K
K2VjaG8gInJtIC1yZiAle2J1aWxkcm9vdH0iDQorZWNobyAibWtkaXIgLXAg
JXtidWlsZHJvb3R9L2Jvb3QgJXtidWlsZHJvb3R9L2xpYi9tb2R1bGVzIg0K
K2VjaG8gIklOU1RBTExfTU9EX1BBVEg9JXtidWlsZHJvb3R9IG1ha2UgbW9k
dWxlc19pbnN0YWxsIiANCitlY2hvICJjcCBhcmNoLyRBUkNIL2Jvb3QvYnpJ
bWFnZSAle2J1aWxkcm9vdH0vYm9vdC9rZXJuZWwtJFZFUlNJT04uJFBBVENI
TEVWRUwuJFNVQkxFVkVMJEVYVFJBVkVSU0lPTi0le3JlbGVhc2V9Ig0KK2Vj
aG8gImNwIFN5c3RlbS5tYXAgJXtidWlsZHJvb3R9L2Jvb3QvU3lzdGVtLm1h
cC0kVkVSU0lPTi4kUEFUQ0hMRVZFTC4kU1VCTEVWRUwkRVhUUkFWRVJTSU9O
LSV7cmVsZWFzZX0iDQorZWNobyAiY3AgLmNvbmZpZyAle2J1aWxkcm9vdH0v
Ym9vdC9jb25maWctJFZFUlNJT04uJFBBVENITEVWRUwuJFNVQkxFVkVMJEVY
VFJBVkVSU0lPTi0le3JlbGVhc2V9Ig0KK2VjaG8NCiBlY2hvICIlY2xlYW4i
DQotZWNobyAnI2VjaG8gLXJmICRSUE1fQlVJTERfUk9PVCcNCi1lY2hvICIi
DQorZWNobyAicm0gLXJmICV7YnVpbGRyb290fSINCitlY2hvDQogZWNobyAi
JWZpbGVzIg0KLWVjaG8gJyVkZWZhdHRyICgtLCByb290LCByb290KScNCitl
Y2hvICIlZGVmYXR0ciAoLSwgcm9vdCwgcm9vdCkiDQorZWNobyAiJWRvYyBD
T1BZSU5HIENSRURJVFMgTUFJTlRBSU5FUlMgUkVBRE1FIFJFUE9SVElORy1C
VUdTIg0KIGVjaG8gIiVkaXIgL2xpYi9tb2R1bGVzIg0KIGVjaG8gIi9saWIv
bW9kdWxlcy8kVkVSU0lPTi4kUEFUQ0hMRVZFTC4kU1VCTEVWRUwkRVhUUkFW
RVJTSU9OIg0KIGVjaG8gIi9ib290LyoiDQotZWNobyAiIg0KK2VjaG8NCitl
Y2hvICIlZmlsZXMgZG9jIg0KK2VjaG8gIiVkb2MgRG9jdW1lbnRhdGlvbi8q
LyovKiINCg==
---858510860-1949473437-997927830=:9367--
