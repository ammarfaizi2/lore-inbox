Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269414AbTGJQJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbTGJQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:09:48 -0400
Received: from routeree.utt.ro ([193.226.8.102]:38366 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S269414AbTGJQIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:08:25 -0400
Message-ID: <60691.194.138.39.55.1057854469.squirrel@webmail.etc.utt.ro>
Date: Thu, 10 Jul 2003 19:27:49 +0300 (EEST)
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <kernel@kolivas.org>
In-Reply-To: <200307081803.23132.kernel@kolivas.org>
References: <200307070317.11246.kernel@kolivas.org>
        <200307071319.57511.kernel@kolivas.org>
        <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
        <200307081803.23132.kernel@kolivas.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030710192749_83559"
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20030710192749_83559
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit

Hi

Sorry for my late answer. I hope it helps even if it's late.

Con Kolivas said:
>
> Ok kick my butt instead so I can try and fix it.
>
>
> Can you tell me how it compares to vanilla at all, and can you watch top
> and  see what dynamic priorities are reported for the cc and mplayer
> processes  while it's running?
>

Test setup: same config (attached) for kernel. Slackware in runlevel 1
(no daemons).
Kernels tested: 2.5.74 vanila, 2.5.74-mm1, 2.5.74-mm2 with your
 patch.
Opening three xterm windows in fvwm2: in one top is feeding
only the running processes in one file, in the
second one "make bzImage" after a make clean with linux-2.4.21
sources and in the third one mplayer /some/movie.avi.
The movie is the same every time.

Results (see atched files):
Vanila kernel is a little bit better than mm. On vanila mplayer has
a smaller priority than cc1 but it still skips frames though is much
smoother. On mm they have the same priority and mplayer skips
worse than on vanila kernel
It seems that gcc uses a lot of cpu while mplayer uses little
cpu so the kernel is favouring the process which eats more cpu .

>> I remeber with nostalgicaly about the times when i could (with a 2.5
>> kernel) do a make -j 5 bzImage AND watch a movie in the same time
>
> <sigh> If it were still the case I wouldn't be spending hundreds of
> hours  doing this :|
>

Sorry if I upset you. I apreciate your's (and other's) work on linux
kernel. I'm not a native english speaker and i was just trying to
give an order of magnitude of how the worse kernel is today
(in terms of multimedia) compared with past times.

> Con

Thanks

Bye
Calin

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


------=_20030710192749_83559
Content-Type: application/octet-stream; name="config"
Content-Disposition: attachment; filename="config"
Content-Transfer-Encoding: base64

Q09ORklHX1g4Nj15CkNPTkZJR19NTVU9eQpDT05GSUdfVUlEMTY9eQpDT05GSUdfR0VORVJJQ19J
U0FfRE1BPXkKCkNPTkZJR19FWFBFUklNRU5UQUw9eQoKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lT
VklQQz15CkNPTkZJR19TWVNDVEw9eQpDT05GSUdfTE9HX0JVRl9TSElGVD0xNApDT05GSUdfRlVU
RVg9eQpDT05GSUdfRVBPTEw9eQoKQ09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9EVUxFX1VOTE9B
RD15CkNPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEPXkKQ09ORklHX09CU09MRVRFX01PRFBBUk09
eQpDT05GSUdfS01PRD15CgpDT05GSUdfWDg2X1BDPXkKQ09ORklHX01LNz15CkNPTkZJR19YODZf
Q01QWENIRz15CkNPTkZJR19YODZfWEFERD15CkNPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NgpD
T05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQpDT05GSUdfWDg2X1dQX1dPUktTX09LPXkK
Q09ORklHX1g4Nl9JTlZMUEc9eQpDT05GSUdfWDg2X0JTV0FQPXkKQ09ORklHX1g4Nl9QT1BBRF9P
Sz15CkNPTkZJR19YODZfR09PRF9BUElDPXkKQ09ORklHX1g4Nl9JTlRFTF9VU0VSQ09QWT15CkNP
TkZJR19YODZfVVNFX1BQUk9fQ0hFQ0tTVU09eQpDT05GSUdfWDg2X1VTRV8zRE5PVz15CkNPTkZJ
R19QUkVFTVBUPXkKQ09ORklHX1g4Nl9UU0M9eQpDT05GSUdfWDg2X01DRT15CkNPTkZJR19YODZf
TUNFX05PTkZBVEFMPXkKQ09ORklHX1g4Nl9DUFVJRD15CkNPTkZJR19OT0hJR0hNRU09eQpDT05G
SUdfMUdCPXkKQ09ORklHX01UUlI9eQpDT05GSUdfSEFWRV9ERUNfTE9DSz15CgpDT05GSUdfUE09
eQoKQ09ORklHX0FQTT15CkNPTkZJR19BUE1fRE9fRU5BQkxFPXkKQ09ORklHX0FQTV9SVENfSVNf
R01UPXkKCgpDT05GSUdfUENJPXkKQ09ORklHX1BDSV9HT0RJUkVDVD15CkNPTkZJR19QQ0lfRElS
RUNUPXkKQ09ORklHX1BDSV9MRUdBQ1lfUFJPQz15CkNPTkZJR19QQ0lfTkFNRVM9eQpDT05GSUdf
SVNBPXkKCkNPTkZJR19LQ09SRV9FTEY9eQpDT05GSUdfQklORk1UX0VMRj15CgoKCkNPTkZJR19Q
QVJQT1JUPXkKQ09ORklHX1BBUlBPUlRfUEM9eQpDT05GSUdfUEFSUE9SVF9QQ19DTUwxPXkKQ09O
RklHX1BBUlBPUlRfUENfRklGTz15CkNPTkZJR19QQVJQT1JUX1BDX1NVUEVSSU89eQpDT05GSUdf
UEFSUE9SVF8xMjg0PXkKCkNPTkZJR19QTlA9eQpDT05GSUdfUE5QX05BTUVTPXkKQ09ORklHX1BO
UF9ERUJVRz15CgpDT05GSUdfSVNBUE5QPXkKQ09ORklHX1BOUEJJT1M9eQoKQ09ORklHX0JMS19E
RVZfRkQ9eQpDT05GSUdfQkxLX0RFVl9MT09QPXkKCkNPTkZJR19JREU9eQoKQ09ORklHX0JMS19E
RVZfSURFPXkKCkNPTkZJR19CTEtfREVWX0lERURJU0s9eQpDT05GSUdfSURFRElTS19NVUxUSV9N
T0RFPXkKQ09ORklHX0JMS19ERVZfSURFQ0Q9eQpDT05GSUdfSURFX1RBU0tGSUxFX0lPPXkKCkNP
TkZJR19CTEtfREVWX0lERVBDST15CkNPTkZJR19CTEtfREVWX0dFTkVSSUM9eQpDT05GSUdfSURF
UENJX1NIQVJFX0lSUT15CkNPTkZJR19CTEtfREVWX0lERURNQV9QQ0k9eQpDT05GSUdfSURFRE1B
X1BDSV9BVVRPPXkKQ09ORklHX0JMS19ERVZfSURFRE1BPXkKQ09ORklHX0JMS19ERVZfQURNQT15
CkNPTkZJR19CTEtfREVWX1ZJQTgyQ1hYWD15CkNPTkZJR19JREVETUFfQVVUTz15CkNPTkZJR19J
REVETUFfSVZCPXkKQ09ORklHX0JMS19ERVZfSURFX01PREVTPXkKCgoKCgoKCkNPTkZJR19ORVQ9
eQoKQ09ORklHX1BBQ0tFVD15CkNPTkZJR19QQUNLRVRfTU1BUD15CkNPTkZJR19ORVRMSU5LX0RF
Vj15CkNPTkZJR19ORVRGSUxURVI9eQpDT05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkKQ09ORklH
X0lQX0FEVkFOQ0VEX1JPVVRFUj15CkNPTkZJR19JUF9ST1VURV9NVUxUSVBBVEg9eQpDT05GSUdf
QVJQRD15CgpDT05GSUdfSVBfTkZfQ09OTlRSQUNLPXkKQ09ORklHX0lQX05GX0ZUUD15CkNPTkZJ
R19JUF9ORl9JUkM9eQpDT05GSUdfSVBfTkZfVEZUUD15CkNPTkZJR19JUF9ORl9JUFRBQkxFUz15
CkNPTkZJR19JUF9ORl9NQVRDSF9MSU1JVD15CkNPTkZJR19JUF9ORl9NQVRDSF9NQUM9eQpDT05G
SUdfSVBfTkZfTUFUQ0hfUEtUVFlQRT15CkNPTkZJR19JUF9ORl9NQVRDSF9NQVJLPXkKQ09ORklH
X0lQX05GX01BVENIX01VTFRJUE9SVD15CkNPTkZJR19JUF9ORl9NQVRDSF9UT1M9eQpDT05GSUdf
SVBfTkZfTUFUQ0hfUkVDRU5UPXkKQ09ORklHX0lQX05GX01BVENIX0VDTj15CkNPTkZJR19JUF9O
Rl9NQVRDSF9EU0NQPXkKQ09ORklHX0lQX05GX01BVENIX0FIX0VTUD15CkNPTkZJR19JUF9ORl9N
QVRDSF9MRU5HVEg9eQpDT05GSUdfSVBfTkZfTUFUQ0hfVFRMPXkKQ09ORklHX0lQX05GX01BVENI
X1RDUE1TUz15CkNPTkZJR19JUF9ORl9NQVRDSF9IRUxQRVI9eQpDT05GSUdfSVBfTkZfTUFUQ0hf
U1RBVEU9eQpDT05GSUdfSVBfTkZfTUFUQ0hfQ09OTlRSQUNLPXkKQ09ORklHX0lQX05GX01BVENI
X1VOQ0xFQU49eQpDT05GSUdfSVBfTkZfTUFUQ0hfT1dORVI9eQpDT05GSUdfSVBfTkZfRklMVEVS
PXkKQ09ORklHX0lQX05GX1RBUkdFVF9SRUpFQ1Q9eQpDT05GSUdfSVBfTkZfVEFSR0VUX01JUlJP
Uj15CkNPTkZJR19JUF9ORl9OQVQ9eQpDT05GSUdfSVBfTkZfTkFUX05FRURFRD15CkNPTkZJR19J
UF9ORl9UQVJHRVRfTUFTUVVFUkFERT15CkNPTkZJR19JUF9ORl9UQVJHRVRfUkVESVJFQ1Q9eQpD
T05GSUdfSVBfTkZfTkFUX0xPQ0FMPXkKQ09ORklHX0lQX05GX05BVF9TTk1QX0JBU0lDPXkKQ09O
RklHX0lQX05GX05BVF9JUkM9eQpDT05GSUdfSVBfTkZfTkFUX0ZUUD15CkNPTkZJR19JUF9ORl9O
QVRfVEZUUD15CkNPTkZJR19JUF9ORl9NQU5HTEU9eQpDT05GSUdfSVBfTkZfVEFSR0VUX1RPUz15
CkNPTkZJR19JUF9ORl9UQVJHRVRfRUNOPXkKQ09ORklHX0lQX05GX1RBUkdFVF9EU0NQPXkKQ09O
RklHX0lQX05GX1RBUkdFVF9NQVJLPXkKQ09ORklHX0lQX05GX1RBUkdFVF9MT0c9eQpDT05GSUdf
SVBfTkZfVEFSR0VUX1VMT0c9eQpDT05GSUdfSVBfTkZfVEFSR0VUX1RDUE1TUz15CkNPTkZJR19J
UF9ORl9BUlBUQUJMRVM9eQpDT05GSUdfSVBfTkZfQVJQRklMVEVSPXkKCkNPTkZJR19JUFY2X1ND
VFBfXz15CgoKQ09ORklHX05FVERFVklDRVM9eQoKCkNPTkZJR19ORVRfRVRIRVJORVQ9eQpDT05G
SUdfTUlJPXkKCkNPTkZJR19ORVRfUENJPXkKQ09ORklHXzgxMzlUT089eQoKCgoKQ09ORklHX1NI
QVBFUj15CgoKCgoKCkNPTkZJR19JTlBVVD15CgpDT05GSUdfSU5QVVRfTU9VU0VERVY9eQpDT05G
SUdfSU5QVVRfTU9VU0VERVZfUFNBVVg9eQpDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1g9
MTAyNApDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1k9NzY4CgpDT05GSUdfU09VTkRfR0FN
RVBPUlQ9eQpDT05GSUdfU0VSSU89eQpDT05GSUdfU0VSSU9fSTgwNDI9eQpDT05GSUdfU0VSSU9f
U0VSUE9SVD15CgpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9
eQpDT05GSUdfSU5QVVRfTU9VU0U9eQpDT05GSUdfTU9VU0VfUFMyPXkKQ09ORklHX0lOUFVUX01J
U0M9eQpDT05GSUdfSU5QVVRfUENTUEtSPXkKCkNPTkZJR19WVD15CkNPTkZJR19WVF9DT05TT0xF
PXkKQ09ORklHX0hXX0NPTlNPTEU9eQoKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklB
TF84MjUwX0VYVEVOREVEPXkKQ09ORklHX1NFUklBTF84MjUwX0RFVEVDVF9JUlE9eQoKQ09ORklH
X1NFUklBTF9DT1JFPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkKQ09ORklHX1VOSVg5OF9QVFlfQ09V
TlQ9NTEyCkNPTkZJR19QUklOVEVSPXkKQ09ORklHX0xQX0NPTlNPTEU9eQoKQ09ORklHX0kyQz15
CkNPTkZJR19JMkNfQUxHT0JJVD15CkNPTkZJR19JMkNfQ0hBUkRFVj15CgpDT05GSUdfSTJDX1ZJ
QVBSTz15CgpDT05GSUdfU0VOU09SU19WSUE2ODZBPXkKQ09ORklHX0kyQ19TRU5TT1I9eQoKCgpD
T05GSUdfTlZSQU09eQpDT05GSUdfUlRDPXkKCkNPTkZJR19BR1A9eQpDT05GSUdfQUdQX1ZJQT15
CkNPTkZJR19EUk09eQpDT05GSUdfRFJNX1JBREVPTj15CgpDT05GSUdfVklERU9fREVWPXkKCkNP
TkZJR19WSURFT19QUk9DX0ZTPXkKCkNPTkZJR19WSURFT19CVDg0OD15CgoKQ09ORklHX1ZJREVP
X1ZJREVPQlVGPXkKQ09ORklHX1ZJREVPX1RVTkVSPXkKQ09ORklHX1ZJREVPX0JVRj15CkNPTkZJ
R19WSURFT19CVENYPXkKCkNPTkZJR19FWFQyX0ZTPXkKQ09ORklHX0VYVDJfRlNfWEFUVFI9eQpD
T05GSUdfRVhUMl9GU19QT1NJWF9BQ0w9eQpDT05GSUdfRVhUM19GUz15CkNPTkZJR19FWFQzX0ZT
X1hBVFRSPXkKQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0pCRD15CkNPTkZJR19G
U19NQkNBQ0hFPXkKQ09ORklHX1JFSVNFUkZTX0ZTPXkKQ09ORklHX0pGU19GUz15CkNPTkZJR19K
RlNfUE9TSVhfQUNMPXkKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19YRlNfRlM9eQoKQ09O
RklHX0lTTzk2NjBfRlM9eQpDT05GSUdfSk9MSUVUPXkKQ09ORklHX1pJU09GUz15CkNPTkZJR19a
SVNPRlNfRlM9eQpDT05GSUdfVURGX0ZTPXkKCkNPTkZJR19GQVRfRlM9eQpDT05GSUdfTVNET1Nf
RlM9eQpDT05GSUdfVkZBVF9GUz15CgpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19ERVZQVFNfRlM9
eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfUkFNRlM9eQoKQ09ORklHX1VGU19GUz15CgpDT05GSUdf
TkZTX0ZTPXkKQ09ORklHX05GU19WMz15CkNPTkZJR19ORlNfRElSRUNUSU89eQpDT05GSUdfTkZT
RD15CkNPTkZJR19ORlNEX1YzPXkKQ09ORklHX05GU0RfVENQPXkKQ09ORklHX0xPQ0tEPXkKQ09O
RklHX0xPQ0tEX1Y0PXkKQ09ORklHX0VYUE9SVEZTPXkKQ09ORklHX1NVTlJQQz15CkNPTkZJR19T
TUJfRlM9eQoKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CkNPTkZJR19NU0RPU19QQVJUSVRJ
T049eQpDT05GSUdfQlNEX0RJU0tMQUJFTD15CkNPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT049
eQpDT05GSUdfU01CX05MUz15CkNPTkZJR19OTFM9eQoKQ09ORklHX05MU19ERUZBVUxUPSJpc284
ODU5LTIiCkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKQ09ORklHX05MU19DT0RFUEFHRV84NTA9
eQpDT05GSUdfTkxTX0NPREVQQUdFXzg1Mj15CkNPTkZJR19OTFNfQ09ERVBBR0VfMTI1MD15CkNP
TkZJR19OTFNfSVNPODg1OV8xPXkKQ09ORklHX05MU19JU084ODU5XzI9eQpDT05GSUdfTkxTX0lT
Tzg4NTlfMTU9eQpDT05GSUdfTkxTX1VURjg9eQoKQ09ORklHX1ZJREVPX1NFTEVDVD15CgpDT05G
SUdfVkdBX0NPTlNPTEU9eQpDT05GSUdfRFVNTVlfQ09OU09MRT15CgpDT05GSUdfU09VTkQ9eQoK
CkNPTkZJR19TT1VORF9QUklNRT15CkNPTkZJR19TT1VORF9CVDg3OD15CkNPTkZJR19TT1VORF9P
U1M9eQpDT05GSUdfU09VTkRfVFJBQ0VJTklUPXkKQ09ORklHX1NPVU5EX0RNQVA9eQpDT05GSUdf
U09VTkRfQ1M0MjMyPXkKQ09ORklHX1NPVU5EX01QVTQwMT15CkNPTkZJR19TT1VORF9UVk1JWEVS
PXkKCgoKCkNPTkZJR19ERUJVR19LRVJORUw9eQpDT05GSUdfREVCVUdfU1RBQ0tPVkVSRkxPVz15
CkNPTkZJR19ERUJVR19TTEFCPXkKQ09ORklHX0RFQlVHX0lPVklSVD15CkNPTkZJR19NQUdJQ19T
WVNSUT15CkNPTkZJR19ERUJVR19QQUdFQUxMT0M9eQpDT05GSUdfS0FMTFNZTVM9eQpDT05GSUdf
REVCVUdfSU5GTz15CgoKCkNPTkZJR19aTElCX0lORkxBVEU9eQpDT05GSUdfWDg2X0JJT1NfUkVC
T09UPXkK
------=_20030710192749_83559
Content-Type: application/octet-stream; name="dmesg"
Content-Disposition: attachment; filename="dmesg"
Content-Transfer-Encoding: base64

TGludXggdmVyc2lvbiAyLjUuNzQtbW0yIChyb290QGdyaW5jaCkgKGdjYyB2ZXJzaW9uIDIuOTUu
MyAyMDAxMDMxNSAocmVsZWFzZSkpICMxIE1vbiBKdWwgNyAyMzoyNjo1MyBFRVNUIDIwMDMKVmlk
ZW8gbW9kZSB0byBiZSB1c2VkIGZvciByZXN0b3JlIGlzIDMwOQpCSU9TLXByb3ZpZGVkIHBoeXNp
Y2FsIFJBTSBtYXA6CiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwMDAwMDAgLSAwMDAwMDAwMDAwMDlm
YzAwICh1c2FibGUpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwOWZjMDAgLSAwMDAwMDAwMDAwMGEw
MDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDAwMDBmMDAwMCAtIDAwMDAwMDAwMDAx
MDAwMDAgKHJlc2VydmVkKQogQklPUy1lODIwOiAwMDAwMDAwMDAwMTAwMDAwIC0gMDAwMDAwMDAw
ZmZmMDAwMCAodXNhYmxlKQogQklPUy1lODIwOiAwMDAwMDAwMDBmZmYwMDAwIC0gMDAwMDAwMDAw
ZmZmMzAwMCAoQUNQSSBOVlMpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMGZmZjMwMDAgLSAwMDAwMDAw
MDEwMDAwMDAwIChBQ1BJIGRhdGEpCiBCSU9TLWU4MjA6IDAwMDAwMDAwZmZmZjAwMDAgLSAwMDAw
MDAwMTAwMDAwMDAwIChyZXNlcnZlZCkKMjU1TUIgTE9XTUVNIGF2YWlsYWJsZS4KT24gbm9kZSAw
IHRvdGFscGFnZXM6IDY1NTIwCiAgRE1BIHpvbmU6IDQwOTYgcGFnZXMsIExJRk8gYmF0Y2g6MQog
IE5vcm1hbCB6b25lOiA2MTQyNCBwYWdlcywgTElGTyBiYXRjaDoxNAogIEhpZ2hNZW0gem9uZTog
MCBwYWdlcywgTElGTyBiYXRjaDoxCkJ1aWxkaW5nIHpvbmVsaXN0IGZvciBub2RlIDogMApLZXJu
ZWwgY29tbWFuZCBsaW5lOiBCT09UX0lNQUdFPWsyNTc0bW0yIHJvIHJvb3Q9MzA2IGlkZTA9YXRh
NjYgaWRlMT1hdGE2NgppZGVfc2V0dXA6IGlkZTA9YXRhNjYKaWRlX3NldHVwOiBpZGUxPWF0YTY2
CkluaXRpYWxpemluZyBDUFUjMApQSUQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlciAx
MDogODE5MiBieXRlcykKRGV0ZWN0ZWQgNzAwLjQwNyBNSHogcHJvY2Vzc29yLgpDb25zb2xlOiBj
b2xvdXIgVkdBKyAxMzJ4MjUKQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiAxMzcyLjE2IEJvZ29N
SVBTCk1lbW9yeTogMjU0NzM2ay8yNjIwODBrIGF2YWlsYWJsZSAoMjIwMmsga2VybmVsIGNvZGUs
IDY2MTZrIHJlc2VydmVkLCA4OTBrIGRhdGEsIDMyMGsgaW5pdCwgMGsgaGlnaG1lbSkKQ2hlY2tp
bmcgaWYgdGhpcyBwcm9jZXNzb3IgaG9ub3VycyB0aGUgV1AgYml0IGV2ZW4gaW4gc3VwZXJ2aXNv
ciBtb2RlLi4uIE9rLgpEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3Jk
ZXI6IDUsIDEzMTA3MiBieXRlcykKSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4
NCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzKQpNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6
IDUxMiAob3JkZXI6IDAsIDQwOTYgYnl0ZXMpCi0+IC9kZXYKLT4gL2Rldi9jb25zb2xlCi0+IC9y
b290CkNQVTogTDEgSSBDYWNoZTogNjRLICg2NCBieXRlcy9saW5lKSwgRCBjYWNoZSA2NEsgKDY0
IGJ5dGVzL2xpbmUpCkNQVTogTDIgQ2FjaGU6IDY0SyAoNjQgYnl0ZXMvbGluZSkKQ1BVOiAgICAg
QWZ0ZXIgZ2VuZXJpYywgY2FwczogMDE4M2Y5ZjcgYzFjN2Y5ZmYgMDAwMDAwMDAgMDAwMDAwMjAK
SW50ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUgc3VwcG9ydGVkLgpJbnRlbCBtYWNoaW5l
IGNoZWNrIHJlcG9ydGluZyBlbmFibGVkIG9uIENQVSMwLgpDUFU6IEFNRCBEdXJvbih0bSkgUHJv
Y2Vzc29yIHN0ZXBwaW5nIDAxCkVuYWJsaW5nIGZhc3QgRlBVIHNhdmUgYW5kIHJlc3RvcmUuLi4g
ZG9uZS4KQ2hlY2tpbmcgJ2hsdCcgaW5zdHJ1Y3Rpb24uLi4gT0suClBPU0lYIGNvbmZvcm1hbmNl
IHRlc3RpbmcgYnkgVU5JRklYCm10cnI6IHYyLjAgKDIwMDIwNTE5KQpJbml0aWFsaXppbmcgUlQg
bmV0bGluayBzb2NrZXQKUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMQpCSU86IHBvb2wg
b2YgMjU2IHNldHVwLCAxNEtiICg1NiBieXRlcy9iaW8pCmJpb3ZlYyBwb29sWzBdOiAgIDEgYnZl
Y3M6IDI1NiBlbnRyaWVzICgxMiBieXRlcykKYmlvdmVjIHBvb2xbMV06ICAgNCBidmVjczogMjU2
IGVudHJpZXMgKDQ4IGJ5dGVzKQpiaW92ZWMgcG9vbFsyXTogIDE2IGJ2ZWNzOiAyNTYgZW50cmll
cyAoMTkyIGJ5dGVzKQpiaW92ZWMgcG9vbFszXTogIDY0IGJ2ZWNzOiAyNTYgZW50cmllcyAoNzY4
IGJ5dGVzKQpiaW92ZWMgcG9vbFs0XTogMTI4IGJ2ZWNzOiAyNTYgZW50cmllcyAoMTUzNiBieXRl
cykKYmlvdmVjIHBvb2xbNV06IDI1NiBidmVjczogMjU2IGVudHJpZXMgKDMwNzIgYnl0ZXMpCkxp
bnV4IFBsdWcgYW5kIFBsYXkgU3VwcG9ydCB2MC45NiAoYykgQWRhbSBCZWxheQpwbnA6IHRoZSBk
cml2ZXIgJ3N5c3RlbScgaGFzIGJlZW4gcmVnaXN0ZXJlZApQblBCSU9TOiBTY2FubmluZyBzeXN0
ZW0gZm9yIFBuUCBCSU9TIHN1cHBvcnQuLi4KUG5QQklPUzogRm91bmQgUG5QIEJJT1MgaW5zdGFs
bGF0aW9uIHN0cnVjdHVyZSBhdCAweGMwMGZiZGYwClBuUEJJT1M6IFBuUCBCSU9TIHZlcnNpb24g
MS4wLCBlbnRyeSAweGYwMDAwOjB4YmUyMCwgZHNlZyAweGYwMDAwCnBucDogbWF0Y2ggZm91bmQg
d2l0aCB0aGUgUG5QIGRldmljZSAnMDA6MDcnIGFuZCB0aGUgZHJpdmVyICdzeXN0ZW0nCnBucDog
bWF0Y2ggZm91bmQgd2l0aCB0aGUgUG5QIGRldmljZSAnMDA6MDgnIGFuZCB0aGUgZHJpdmVyICdz
eXN0ZW0nCnBucDogbWF0Y2ggZm91bmQgd2l0aCB0aGUgUG5QIGRldmljZSAnMDA6MGInIGFuZCB0
aGUgZHJpdmVyICdzeXN0ZW0nClBuUEJJT1M6IDE2IG5vZGVzIHJlcG9ydGVkIGJ5IFBuUCBCSU9T
OyAxNiByZWNvcmRlZCBieSBkcml2ZXIKUENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZQpQQ0k6IFBy
b2JpbmcgUENJIGhhcmR3YXJlIChidXMgMDApCkRpc2FibGluZyBWSUEgbWVtb3J5IHdyaXRlIHF1
ZXVlIChQQ0kgSUQgMDMwNSwgcmV2IDAyKTogWzU1XSA4MSAmIDFmIC0+IDAxClBDSTogVXNpbmcg
SVJRIHJvdXRlciBWSUEgWzExMDYvMDY4Nl0gYXQgMDAwMDowMDowNy4wCnB0eTogNTEyIFVuaXg5
OCBwdHlzIGNvbmZpZ3VyZWQKTWFjaGluZSBjaGVjayBleGNlcHRpb24gcG9sbGluZyB0aW1lciBz
dGFydGVkLgphcG06IEJJT1MgdmVyc2lvbiAxLjIgRmxhZ3MgMHgwNyAoRHJpdmVyIHZlcnNpb24g
MS4xNmFjKQpFbmFibGluZyBTRVAgb24gQ1BVIDAKQ29kYSBLZXJuZWwvVmVudXMgY29tbXVuaWNh
dGlvbnMsIHY1LjMuMTUsIGNvZGFAY3MuY211LmVkdQpJbnN0YWxsaW5nIGtuZnNkIChjb3B5cmln
aHQgKEMpIDE5OTYgb2tpckBtb25hZC5zd2IuZGUpLgp1ZGY6IHJlZ2lzdGVyaW5nIGZpbGVzeXN0
ZW0KaXNhcG5wOiBTY2FubmluZyBmb3IgUG5QIGNhcmRzLi4uCmlzYXBucDogQ2FyZCAnQ3J5c3Rh
bCBDb2RlYycKaXNhcG5wOiAxIFBsdWcgJiBQbGF5IGNhcmQgZGV0ZWN0ZWQgdG90YWwKcmVxdWVz
dF9tb2R1bGU6IGZhaWxlZCAvc2Jpbi9tb2Rwcm9iZSAtLSBwYXJwb3J0X2xvd2xldmVsLiBlcnJv
ciA9IC0xNgpscDogZHJpdmVyIGxvYWRlZCBidXQgbm8gZGV2aWNlcyBmb3VuZApSZWFsIFRpbWUg
Q2xvY2sgRHJpdmVyIHYxLjExCk5vbi12b2xhdGlsZSBtZW1vcnkgZHJpdmVyIHYxLjIKTGludXgg
YWdwZ2FydCBpbnRlcmZhY2UgdjAuMTAwIChjKSBEYXZlIEpvbmVzCmFncGdhcnQ6IERldGVjdGVk
IFZJQSBBcG9sbG8gUHJvIEtUMTMzL0tNMTMzL1R3aXN0ZXJLIGNoaXBzZXQKYWdwZ2FydDogTWF4
aW11bSBtYWluIG1lbW9yeSB0byB1c2UgZm9yIGFncCBtZW1vcnk6IDIwM00KYWdwZ2FydDogQUdQ
IGFwZXJ0dXJlIGlzIDEyOE0gQCAweGQwMDAwMDAwCltkcm1dIEluaXRpYWxpemVkIHJhZGVvbiAx
LjguMCAyMDAyMDgyOCBvbiBtaW5vciAwClNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIgJFJldmlz
aW9uOiAxLjkwICQgSVJRIHNoYXJpbmcgZGlzYWJsZWQKdHR5UzAgYXQgSS9PIDB4M2Y4IChpcnEg
PSA0KSBpcyBhIDE2NTUwQQp0dHlTMSBhdCBJL08gMHgyZjggKGlycSA9IDMpIGlzIGEgMTY1NTBB
CnBucDogdGhlIGRyaXZlciAnc2VyaWFsJyBoYXMgYmVlbiByZWdpc3RlcmVkCnBucDogbWF0Y2gg
Zm91bmQgd2l0aCB0aGUgUG5QIGRldmljZSAnMDA6MGQnIGFuZCB0aGUgZHJpdmVyICdzZXJpYWwn
CnBucDogbWF0Y2ggZm91bmQgd2l0aCB0aGUgUG5QIGRldmljZSAnMDA6MGUnIGFuZCB0aGUgZHJp
dmVyICdzZXJpYWwnCnBucDogdGhlIGRyaXZlciAncGFycG9ydF9wYycgaGFzIGJlZW4gcmVnaXN0
ZXJlZApwbnA6IG1hdGNoIGZvdW5kIHdpdGggdGhlIFBuUCBkZXZpY2UgJzAwOjEwJyBhbmQgdGhl
IGRyaXZlciAncGFycG9ydF9wYycKcGFycG9ydDA6IFBDLXN0eWxlIGF0IDB4M2JjICgweDdiYykg
W1BDU1BQLFRSSVNUQVRFXQpwYXJwb3J0MDogY3BwX2RhaXN5OiBhYTU1MDBmZigzOCkKcGFycG9y
dDA6IGFzc2lnbl9hZGRyczogYWE1NTAwZmYoMzgpCnBhcnBvcnQwOiBjcHBfZGFpc3k6IGFhNTUw
MGZmKDM4KQpwYXJwb3J0MDogYXNzaWduX2FkZHJzOiBhYTU1MDBmZigzOCkKbHAwOiB1c2luZyBw
YXJwb3J0MCAocG9sbGluZykuCmxwMDogY29uc29sZSByZWFkeQpwYXJwb3J0X3BjOiBWaWEgNjg2
QSBwYXJhbGxlbCBwb3J0OiBpbz0weDNCQwphbnRpY2lwYXRvcnkgc2NoZWR1bGluZyBlbGV2YXRv
cgpGbG9wcHkgZHJpdmUocyk6IGZkMCBpcyAxLjQ0TQpGREMgMCBpcyBhIHBvc3QtMTk5MSA4MjA3
Nwpsb29wOiBsb2FkZWQgKG1heCA4IGRldmljZXMpCjgxMzl0b28gRmFzdCBFdGhlcm5ldCBkcml2
ZXIgMC45LjI2ClBDSTogRm91bmQgSVJRIDEwIGZvciBkZXZpY2UgMDAwMDowMDowOC4wCmV0aDA6
IFJlYWxUZWsgUlRMODEzOSBGYXN0IEV0aGVybmV0IGF0IDB4ZDA4ODQwMDAsIDAwOjQwOmY0Ojcy
Ojk5OmIzLCBJUlEgMTAKZXRoMDogIElkZW50aWZpZWQgODEzOSBjaGlwIHR5cGUgJ1JUTC04MTM5
QycKUENJOiBGb3VuZCBJUlEgMTEgZm9yIGRldmljZSAwMDAwOjAwOjBhLjAKZXRoMTogUmVhbFRl
ayBSVEw4MTM5IEZhc3QgRXRoZXJuZXQgYXQgMHhkMDg4NjAwMCwgMDA6NDA6ZjQ6NzQ6NmQ6ZmIs
IElSUSAxMQpldGgxOiAgSWRlbnRpZmllZCA4MTM5IGNoaXAgdHlwZSAnUlRMLTgxMzlDJwpMaW51
eCB2aWRlbyBjYXB0dXJlIGludGVyZmFjZTogdjEuMDAKYnR0djogZHJpdmVyIHZlcnNpb24gMC45
LjQgbG9hZGVkCmJ0dHY6IHVzaW5nIDggYnVmZmVycyB3aXRoIDIwODBrICg1MjAgcGFnZXMpIGVh
Y2ggZm9yIGNhcHR1cmUKYnR0djogSG9zdCBicmlkZ2UgaXMgVklBIFRlY2hub2xvZ2llcywgSW4g
VlQ4MzYzLzgzNjUgW0tUMTMzL0sKYnR0djogSG9zdCBicmlkZ2UgaXMgVklBIFRlY2hub2xvZ2ll
cywgSW4gVlQ4MkM2ODYgW0Fwb2xsbyBTdXAKYnR0djogQnQ4eHggY2FyZCBmb3VuZCAoMCkuClBD
STogRm91bmQgSVJRIDkgZm9yIGRldmljZSAwMDAwOjAwOjA5LjAKUENJOiBTaGFyaW5nIElSUSA5
IHdpdGggMDAwMDowMDowOS4xCmJ0dHYwOiBCdDg3OCAocmV2IDIpIGF0IDAwMDA6MDA6MDkuMCwg
aXJxOiA5LCBsYXRlbmN5OiAzMiwgbW1pbzogMHhlMjAwMTAwMApidHR2MDogZGV0ZWN0ZWQ6IEFW
ZXJtZWRpYSBUVkNhcHR1cmUgOTggW2NhcmQ9MTNdLCBQQ0kgc3Vic3lzdGVtIElEIGlzIDE0NjE6
MDAwMgpidHR2MDogdXNpbmc6IEJUODc4KEFWZXJNZWRpYSBUVkNhcHR1cmUgOTgpIFtjYXJkPTEz
LGF1dG9kZXRlY3RlZF0KYnR0djA6IEF2ZXJtZWRpYSBlZXByb21bMHg0MDExXTogdHVuZXI9NSBy
YWRpbzpubyByZW1vdGUgY29udHJvbDp5ZXMKYnR0djA6IHVzaW5nIHR1bmVyPTUKYnR0djA6IGky
YzogY2hlY2tpbmcgZm9yIE1TUDM0eHggQCAweDgwLi4uIG5vdCBmb3VuZApidHR2MDogaTJjOiBj
aGVja2luZyBmb3IgVERBOTg3NSBAIDB4YjAuLi4gbm90IGZvdW5kCmJ0dHYwOiBpMmM6IGNoZWNr
aW5nIGZvciBUREE3NDMyIEAgMHg4YS4uLiBub3QgZm91bmQKYnR0djA6IHJlZ2lzdGVyZWQgZGV2
aWNlIHZpZGVvMApidHR2MDogcmVnaXN0ZXJlZCBkZXZpY2UgdmJpMApidHR2MDogUExMOiAyODYz
NjM2MyA9PiAzNTQ2ODk1MCAuLiBvawp0dmF1ZGlvOiBUViBhdWRpbyBkZWNvZGVyICsgYXVkaW8v
dmlkZW8gbXV4IGRyaXZlcgp0dmF1ZGlvOiBrbm93biBjaGlwczogdGRhOTg0MCx0ZGE5ODczaCx0
ZGE5ODc0aC9hLHRkYTk4NTAsdGRhOTg1NSx0ZWE2MzAwLHRlYTY0MjAsdGRhODQyNSxwaWMxNmM1
NCAoUFY5NTEpLHRhODg3NHoKdHVuZXI6IGNoaXAgZm91bmQgQCAweGMyCnR1bmVyOiB0eXBlIHNl
dCB0byA1IChQaGlsaXBzIFBBTF9CRyAoRkkxMjE2IGFuZCBjb21wYXRpYmxlcykpCnJlZ2lzdGVy
aW5nIDAtMDA2MQpVbmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjog
Ny4wMGFscGhhMgppZGU6IEFzc3VtaW5nIDMzTUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBt
b2Rlczsgb3ZlcnJpZGUgd2l0aCBpZGVidXM9eHgKVlBfSURFOiBJREUgY29udHJvbGxlciBhdCBQ
Q0kgc2xvdCAwMDAwOjAwOjA3LjEKVlBfSURFOiBjaGlwc2V0IHJldmlzaW9uIDE2ClZQX0lERTog
bm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwgcHJvYmUgaXJxcyBsYXRlcgpWUF9JREU6IFZJQSB2
dDgyYzY4NmEgKHJldiAyMikgSURFIFVETUE2NiBjb250cm9sbGVyIG9uIHBjaTAwMDA6MDA6MDcu
MQogICAgaWRlMDogQk0tRE1BIGF0IDB4ZDAwMC0weGQwMDcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpE
TUEsIGhkYjpwaW8KICAgIGlkZTE6IEJNLURNQSBhdCAweGQwMDgtMHhkMDBmLCBCSU9TIHNldHRp
bmdzOiBoZGM6RE1BLCBoZGQ6cGlvCmhkYTogTWF4dG9yIDJGMDQwSjAsIEFUQSBESVNLIGRyaXZl
CmlkZTAgYXQgMHgxZjAtMHgxZjcsMHgzZjYgb24gaXJxIDE0CmhkYzogU09OWSBDRFU0ODExLCBB
VEFQSSBDRC9EVkQtUk9NIGRyaXZlCmlkZTEgYXQgMHgxNzAtMHgxNzcsMHgzNzYgb24gaXJxIDE1
CmhkYTogbWF4IHJlcXVlc3Qgc2l6ZTogMTI4S2lCCmhkYTogaG9zdCBwcm90ZWN0ZWQgYXJlYSA9
PiAxCmhkYTogODAyOTMyNDggc2VjdG9ycyAoNDExMTAgTUIpIHcvMjA0OEtpQiBDYWNoZSwgQ0hT
PTc5NjU2LzE2LzYzLCBVRE1BKDY2KQogaGRhOiBoZGExIGhkYTIgaGRhMyBoZGE0IDwgaGRhNSBo
ZGE2IGhkYTcgaGRhOCBoZGE5ID4KaGRjOiBBVEFQSSA0OFggQ0QtUk9NIGRyaXZlLCAxMjBrQiBD
YWNoZSwgVURNQSgzMykKVW5pZm9ybSBDRC1ST00gZHJpdmVyIFJldmlzaW9uOiAzLjEyCm1pY2U6
IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKaW5wdXQ6IFBDIFNwZWFrZXIK
aW5wdXQ6IFBTLzIgR2VuZXJpYyBNb3VzZSBvbiBpc2EwMDYwL3NlcmlvMQpzZXJpbzogaTgwNDIg
QVVYIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgppbnB1dDogQVQgU2V0IDIga2V5Ym9hcmQgb24g
aXNhMDA2MC9zZXJpbzAKc2VyaW86IGk4MDQyIEtCRCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMQpp
MmMgL2RldiBlbnRyaWVzIGRyaXZlciBtb2R1bGUgdmVyc2lvbiAyLjcuMCAoMjAwMjEyMDgpCnBu
cDogdGhlIGRyaXZlciAnY3M0MjMyJyBoYXMgYmVlbiByZWdpc3RlcmVkCnBucDogbWF0Y2ggZm91
bmQgd2l0aCB0aGUgUG5QIGRldmljZSAnMDE6MDEuMDAnIGFuZCB0aGUgZHJpdmVyICdjczQyMzIn
CnBucDogRGV2aWNlIDAxOjAxLjAwIGFjdGl2YXRlZC4KPENyeXN0YWwgYXVkaW8gY29udHJvbGxl
ciAoQ1M0MjM5KT4gYXQgMHg1MzQgaXJxIDUgZG1hIDEsMQphZDE4NDg6IEludGVycnVwdCB0ZXN0
IGZhaWxlZCAoSVJRNSkKYWQxODQ4L2NzNDI0OCBjb2RlYyBkcml2ZXIgQ29weXJpZ2h0IChDKSBi
eSBIYW5udSBTYXZvbGFpbmVuIDE5OTMtMTk5NgphZDE4NDg6IE5vIElTQVBuUCBjYXJkcyBmb3Vu
ZCwgdHJ5aW5nIHN0YW5kYXJkIG9uZXMuLi4KYnRhdWRpbzogZHJpdmVyIHZlcnNpb24gMC43IGxv
YWRlZCBbZGlnaXRhbCthbmFsb2ddClBDSTogRm91bmQgSVJRIDkgZm9yIGRldmljZSAwMDAwOjAw
OjA5LjEKUENJOiBTaGFyaW5nIElSUSA5IHdpdGggMDAwMDowMDowOS4wCmJ0YXVkaW86IEJ0ODc4
IChyZXYgMikgYXQgMDA6MDkuMSwgaXJxOiA5LCBsYXRlbmN5OiAzMiwgbW1pbzogMHhlMjAwMjAw
MApidGF1ZGlvOiB1c2luZyBjYXJkIGNvbmZpZyAiZGVmYXVsdCIKYnRhdWRpbzogcmVnaXN0ZXJl
ZCBkZXZpY2UgZHNwMSBbZGlnaXRhbF0KYnRhdWRpbzogcmVnaXN0ZXJlZCBkZXZpY2UgZHNwMiBb
YW5hbG9nXQpidGF1ZGlvOiByZWdpc3RlcmVkIGRldmljZSBtaXhlcjEKTkVUNDogTGludXggVENQ
L0lQIDEuMCBmb3IgTkVUNC4wCklQOiByb3V0aW5nIGNhY2hlIGhhc2ggdGFibGUgb2YgMjA0OCBi
dWNrZXRzLCAxNktieXRlcwpUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVk
IDE2Mzg0IGJpbmQgMTYzODQpCmlwX2Nvbm50cmFjayB2ZXJzaW9uIDIuMSAoMjA0NyBidWNrZXRz
LCAxNjM3NiBtYXgpIC0gMzA0IGJ5dGVzIHBlciBjb25udHJhY2sKaXBfdGFibGVzOiAoQykgMjAw
MC0yMDAyIE5ldGZpbHRlciBjb3JlIHRlYW0KaXB0X3JlY2VudCB2MC4zLjE6IFN0ZXBoZW4gRnJv
c3QgPHNmcm9zdEBzbm93bWFuLm5ldD4uICBodHRwOi8vc25vd21hbi5uZXQvcHJvamVjdHMvaXB0
X3JlY2VudC8KYXJwX3RhYmxlczogKEMpIDIwMDIgRGF2aWQgUy4gTWlsbGVyCk5FVDQ6IFVuaXgg
ZG9tYWluIHNvY2tldHMgMS4wL1NNUCBmb3IgTGludXggTkVUNC4wLgpZb3UgZGlkbid0IHNwZWNp
ZnkgdGhlIHR5cGUgb2YgeW91ciB1ZnMgZmlsZXN5c3RlbQoKbW91bnQgLXQgdWZzIC1vIHVmc3R5
cGU9c3VufHN1bng4Nnw0NGJzZHxvbGR8aHB8bmV4dHN0ZXB8bmV0eHN0ZXAtY2R8b3BlbnN0ZXAg
Li4uCgo+Pj5XQVJOSU5HPDw8IFdyb25nIHVmc3R5cGUgbWF5IGNvcnJ1cHQgeW91ciBmaWxlc3lz
dGVtLCBkZWZhdWx0IGlzIHVmc3R5cGU9b2xkCnVmc19yZWFkX3N1cGVyOiBiYWQgbWFnaWMgbnVt
YmVyClVERi1mcyBERUJVRyBmcy91ZGYvbG93bGV2ZWwuYzo2NTp1ZGZfZ2V0X2xhc3Rfc2Vzc2lv
bjogQ0RST01NVUxUSVNFU1NJT04gbm90IHN1cHBvcnRlZDogcmM9LTIyClVERi1mcyBERUJVRyBm
cy91ZGYvc3VwZXIuYzoxNDcyOnVkZl9maWxsX3N1cGVyOiBNdWx0aS1zZXNzaW9uPTAKVURGLWZz
IERFQlVHIGZzL3VkZi9zdXBlci5jOjQ2MDp1ZGZfdnJzOiBTdGFydGluZyBhdCBzZWN0b3IgMTYg
KDIwNDggYnl0ZSBzZWN0b3JzKQpVREYtZnM6IE5vIFZSUyBmb3VuZApWRlM6IE1vdW50ZWQgcm9v
dCAoamZzIGZpbGVzeXN0ZW0pIHJlYWRvbmx5LgpGcmVlaW5nIHVudXNlZCBrZXJuZWwgbWVtb3J5
OiAzMjBrIGZyZWVkCkFkZGluZyA1MzAxMDhrIHN3YXAgb24gL2Rldi9oZGE3LiAgUHJpb3JpdHk6
LTEgZXh0ZW50czoxCmV0aDA6IFNldHRpbmcgaGFsZi1kdXBsZXggYmFzZWQgb24gYXV0by1uZWdv
dGlhdGVkIHBhcnRuZXIgYWJpbGl0eSAwMDAwLgpwcm9jZXNzIGBzeXNsb2dkJyBpcyB1c2luZyBv
YnNvbGV0ZSBzZXRzb2Nrb3B0IFNPX0JTRENPTVBBVApldGgxOiBTZXR0aW5nIGhhbGYtZHVwbGV4
IGJhc2VkIG9uIGF1dG8tbmVnb3RpYXRlZCBwYXJ0bmVyIGFiaWxpdHkgMDAwMC4KYWdwZ2FydDog
Rm91bmQgYW4gQUdQIDIuMCBjb21wbGlhbnQgZGV2aWNlIGF0IDAwMDA6MDA6MDAuMC4KYWdwZ2Fy
dDogUHV0dGluZyBBR1AgVjIgZGV2aWNlIGF0IDAwMDA6MDA6MDAuMCBpbnRvIDR4IG1vZGUKYWdw
Z2FydDogUHV0dGluZyBBR1AgVjIgZGV2aWNlIGF0IDAwMDA6MDE6MDAuMCBpbnRvIDR4IG1vZGUK
Y2Ryb206IG9wZW4gZmFpbGVkLgpjZHJvbTogb3BlbiBmYWlsZWQuCklTTyA5NjYwIEV4dGVuc2lv
bnM6IE1pY3Jvc29mdCBKb2xpZXQgTGV2ZWwgMwpJU09GUzogY2hhbmdpbmcgdG8gc2Vjb25kYXJ5
IHJvb3QKc3B1cmlvdXMgODI1OUEgaW50ZXJydXB0OiBJUlE3LgpJU08gOTY2MCBFeHRlbnNpb25z
OiBNaWNyb3NvZnQgSm9saWV0IExldmVsIDMKSVNPIDk2NjAgRXh0ZW5zaW9uczogUlJJUF8xOTkx
QQpJU08gOTY2MCBFeHRlbnNpb25zOiBNaWNyb3NvZnQgSm9saWV0IExldmVsIDMKSVNPRlM6IGNo
YW5naW5nIHRvIHNlY29uZGFyeSByb290CmNkcm9tOiBvcGVuIGZhaWxlZC4KY2Ryb206IG9wZW4g
ZmFpbGVkLgo=
------=_20030710192749_83559
Content-Type: text/plain; name="toprun-2574.txt"
Content-Disposition: attachment; filename="toprun-2574.txt"

top - 23:27:42 up 2 min,  4 users,  load average: 0.12, 0.08, 0.02
Tasks:  36 total,   1 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):   4.3% user,   6.2% system,   0.0% nice,  73.5% idle,  16.0% IO-wait
Mem:    255016k total,   104540k used,   150476k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58776k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  203 root      20   0  1872  956 1764 R  2.0  0.4   0:00.02 top                  


top - 23:27:42 up 2 min,  4 users,  load average: 0.12, 0.08, 0.02
Tasks:  36 total,   1 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait
Mem:    255016k total,   104540k used,   150476k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58780k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  203 root      20   0  1884 1024 1764 R  2.0  0.4   0:00.03 top                  


top - 23:27:43 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  36 total,   1 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):   2.0% user,   5.9% system,   0.0% nice,  92.2% idle,   0.0% IO-wait
Mem:    255016k total,   104540k used,   150476k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58780k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  203 root      19   0  1884 1024 1764 R  2.0  0.4   0:00.04 top                  


top - 23:27:43 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  36 total,   1 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):   3.8% user,   3.8% system,   0.0% nice,  92.3% idle,   0.0% IO-wait
Mem:    255016k total,   104540k used,   150476k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58780k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  203 root      19   0  1884 1024 1764 R  2.0  0.4   0:00.05 top                  


top - 23:27:44 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  37 total,   2 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  12.0% user,   6.0% system,   0.0% nice,  82.0% idle,   0.0% IO-wait
Mem:    255016k total,   105276k used,   149740k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58780k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0  8964 2080 7964 R  7.8  0.8   0:00.04 mplayer              
  203 root      18   0  1884 1024 1764 R  2.0  0.4   0:00.06 top                  


top - 23:27:44 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  37 total,   2 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  58.0% user,  28.0% system,   0.0% nice,  14.0% idle,   0.0% IO-wait
Mem:    255016k total,   114468k used,   140548k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58996k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17724  11m 8260 R 49.0  4.7   0:00.29 mplayer              
  203 root      18   0  1884 1024 1764 R  2.0  0.4   0:00.07 top                  


top - 23:27:45 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  37 total,   2 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  18.9% user,   7.5% system,   0.0% nice,  73.6% idle,   0.0% IO-wait
Mem:    255016k total,   114692k used,   140324k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58996k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R  7.8  4.8   0:00.33 mplayer              
  203 root      17   0  1884 1024 1764 R  0.0  0.4   0:00.07 top                  


top - 23:27:46 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  37 total,   2 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  23.5% user,   5.9% system,   0.0% nice,  70.6% idle,   0.0% IO-wait
Mem:    255016k total,   114692k used,   140324k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    58996k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 13.7  4.8   0:00.40 mplayer              
  203 root      17   0  1884 1024 1764 R  3.9  0.4   0:00.09 top                  


top - 23:27:46 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  38 total,   3 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  30.0% user,  18.0% system,   0.0% nice,  52.0% idle,   0.0% IO-wait
Mem:    255016k total,   115324k used,   139692k free,     8600k buffers
Swap:   530108k total,        0k used,   530108k free,    59004k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 11.8  4.8   0:00.46 mplayer              
  209 root      23   0  1844 1044 1356 R 11.8  0.4   0:00.06 make                 
  203 root      16   0  1884 1024 1764 R  2.0  0.4   0:00.10 top                  


top - 23:27:47 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  42 total,   3 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  28.8% user,  13.5% system,   0.0% nice,   0.0% idle,  57.7% IO-wait
Mem:    255016k total,   116500k used,   138516k free,     8716k buffers
Swap:   530108k total,        0k used,   530108k free,    59172k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 11.7  4.8   0:00.52 mplayer              
  203 root      16   0  1884 1024 1764 R  2.0  0.4   0:00.11 top                  
  224 root      25   0  1444  500 1320 D  0.0  0.2   0:00.00 cpp0                 
  225 root      25   0  3060 1004 2860 D  0.0  0.4   0:00.00 cc1                  
  226 root      25   0  2024  288 1960 R  0.0  0.1   0:00.00 as                   


top - 23:27:47 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  17.6% user,   7.8% system,   0.0% nice,   0.0% idle,  74.5% IO-wait
Mem:    255016k total,   117564k used,   137452k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    59784k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 13.7  4.8   0:00.59 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.13 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.15 xsnow                
  224 root      24   0  1712  740 1320 R  0.0  0.3   0:00.00 cpp0                 


top - 23:27:48 up 2 min,  4 users,  load average: 0.11, 0.08, 0.02
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  21.6% user,   5.9% system,   0.0% nice,   0.0% idle,  72.5% IO-wait
Mem:    255016k total,   118068k used,   136948k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    60080k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 13.7  4.8   0:00.66 mplayer              
  224 root      24   0  1980  992 1320 R  7.8  0.4   0:00.04 cpp0                 
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.15 xsnow                
  203 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.13 top                  


top - 23:27:48 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  17.6% user,   9.8% system,   0.0% nice,   0.0% idle,  72.5% IO-wait
Mem:    255016k total,   118572k used,   136444k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    60388k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 15.6  4.8   0:00.74 mplayer              
  224 root      24   0  2068 1132 1320 R  3.9  0.4   0:00.06 cpp0                 
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.14 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.15 xsnow                


top - 23:27:49 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   3 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  31.4% user,  15.7% system,   0.0% nice,   0.0% idle,  52.9% IO-wait
Mem:    255016k total,   119196k used,   135820k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    60732k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 15.6  4.8   0:00.82 mplayer              
  224 root      23   0  2388 1404 1320 R  7.8  0.6   0:00.10 cpp0                 
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.16 top                  


top - 23:27:49 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  27.5% user,   7.8% system,   0.0% nice,   0.0% idle,  64.7% IO-wait
Mem:    255016k total,   120148k used,   134868k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    61104k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      21   0 17940  11m 8260 R 13.6  4.8   0:00.89 mplayer              
  203 root      15   0  1888 1028 1764 R  1.9  0.4   0:00.17 top                  
  225 root      25   0  3116 1264 2860 R  1.9  0.5   0:00.01 cc1                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                


top - 23:27:50 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  75.0% user,   9.6% system,   0.0% nice,   0.0% idle,  15.4% IO-wait
Mem:    255016k total,   122556k used,   132460k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    61300k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  225 root      25   0  5352 3840 2860 R 54.5  1.5   0:00.29 cc1                  
  204 root      21   0 17940  11m 8260 R 15.6  4.8   0:00.97 mplayer              
  203 root      15   0  1888 1028 1764 R  1.9  0.4   0:00.18 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                


top - 23:27:50 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   124740k used,   130276k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    61300k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  225 root      25   0  7552 6040 2860 R 70.3  2.4   0:00.65 cc1                  
  204 root      22   0 17940  11m 8260 R 17.6  4.8   0:01.06 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.20 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                


top - 23:27:51 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  41 total,   3 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  75.0% user,  11.5% system,   0.0% nice,   0.0% idle,  13.5% IO-wait
Mem:    255016k total,   124340k used,   130676k free,     8724k buffers
Swap:   530108k total,        0k used,   530108k free,    61576k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  225 root      25   0  8344 7296 2860 R 56.6  2.9   0:00.94 cc1                  
  204 root      22   0 17940  11m 8260 R 17.6  4.8   0:01.15 mplayer              
  203 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.21 top                  


top - 23:27:51 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  41 total,   3 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  41.2% user,  21.6% system,   0.0% nice,   0.0% idle,  37.3% IO-wait
Mem:    255016k total,   119364k used,   135652k free,     8760k buffers
Swap:   530108k total,        0k used,   530108k free,    62120k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  204 root      22   0 17940  11m 8260 R 13.7  4.8   0:01.22 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.22 top                  
  266 root      25   0  1052  600  956 R  0.0  0.2   0:00.00 sh                   


top - 23:27:52 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  68.6% user,  17.6% system,   0.0% nice,   0.0% idle,  13.7% IO-wait
Mem:    255016k total,   122244k used,   132772k free,     8760k buffers
Swap:   530108k total,        0k used,   530108k free,    62308k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  275 root      25   0  4256 2728 2860 R 23.4  1.1   0:00.12 cc1                  
  274 root      25   0  2880 1628 1320 R 21.5  0.6   0:00.11 cpp0                 
  204 root      22   0 17940  11m 8260 R 15.6  4.8   0:01.30 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.24 top                  


top - 23:27:52 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.2% user,  11.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   124428k used,   130588k free,     8760k buffers
Swap:   530108k total,        0k used,   530108k free,    62308k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  275 root      25   0  6436 4924 2860 R 70.3  1.9   0:00.48 cc1                  
  204 root      22   0 17940  11m 8260 R 17.6  4.8   0:01.39 mplayer              
  203 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.24 top                  
  274 root      25   0  2880 1628 1320 R  0.0  0.6   0:00.11 cpp0                 


top - 23:27:53 up 2 min,  4 users,  load average: 0.18, 0.09, 0.03
Tasks:  42 total,   3 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   126164k used,   128852k free,     8760k buffers
Swap:   530108k total,        0k used,   530108k free,    62308k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  275 root      25   0  8148 7100 2860 R 70.3  2.8   0:00.84 cc1                  
  204 root      22   0 17940  11m 8260 R 17.6  4.8   0:01.48 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.25 top                  


top - 23:27:53 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  40 total,   4 running,  36 sleeping,   0 stopped,   0 zombie
Cpu(s):  78.8% user,  17.3% system,   0.0% nice,   0.0% idle,   3.8% IO-wait
Mem:    255016k total,   120604k used,   134412k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62344k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  278 root      25   0  2008 1240 1356 R 19.5  0.5   0:00.10 make                 
  204 root      22   0 17940  11m 8260 R 17.6  4.8   0:01.57 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.27 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                


top - 23:27:54 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   5 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  68.6% user,  19.6% system,   0.0% nice,   0.0% idle,  11.8% IO-wait
Mem:    255016k total,   124116k used,   130900k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62448k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  281 root      25   0  4568 3048 2860 R 31.2  1.2   0:00.16 cc1                  
  204 root      22   0 17940  11m 8260 R 15.6  4.8   0:01.65 mplayer              
  280 root      25   0  2728 1528 1320 R 15.6  0.6   0:00.08 cpp0                 
  203 root      15   0  1888 1028 1764 R  1.9  0.4   0:00.28 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                


top - 23:27:54 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   5 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   126244k used,   128772k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62452k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  281 root      25   0  6700 5188 2860 R 70.2  2.0   0:00.52 cc1                  
  204 root      22   0 17940  11m 8260 R 17.6  4.8   0:01.74 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.29 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                
  280 root      25   0  2728 1528 1320 R  0.0  0.6   0:00.08 cpp0                 


top - 23:27:55 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   5 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   127252k used,   127764k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62452k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  281 root      25   0  7516 6472 2860 R 74.2  2.5   0:00.90 cc1                  
  204 root      22   0 17940  11m 8260 R 13.7  4.8   0:01.81 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.31 top                  
  113 root      15   0  2484 1044 2340 R  0.0  0.4   0:00.16 xsnow                
  280 root      25   0  2728 1528 1320 R  0.0  0.6   0:00.08 cpp0                 


top - 23:27:55 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   127476k used,   127540k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62452k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  281 root      25   0  7708 6664 2860 R 70.2  2.6   0:01.26 cc1                  
  204 root      22   0 17940  11m 8260 R 15.6  4.8   0:01.89 mplayer              
  203 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.31 top                  
  280 root      25   0  2728 1528 1320 R  0.0  0.6   0:00.08 cpp0                 


top - 23:27:56 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.4% user,   9.6% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   127756k used,   127260k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62452k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  281 root      25   0  8116 7072 2860 R 72.3  2.8   0:01.63 cc1                  
  204 root      22   0 17940  11m 8260 R 15.6  4.8   0:01.97 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.33 top                  


top - 23:27:56 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   126516k used,   128500k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62452k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  281 root      25   0  7860 6820 2860 R 66.3  2.7   0:01.97 cc1                  
  204 root      22   0 17940  11m 8260 R 11.7  4.8   0:02.03 mplayer              
  203 root      15   0  1888 1028 1764 R  1.9  0.4   0:00.34 top                  


top - 23:27:57 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  84.3% user,  15.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   124172k used,   130844k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62484k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  287 root      25   0  4728 3208 2860 R 39.1  1.3   0:00.20 cc1                  
  286 root      25   0  2476 1408 1320 R 13.7  0.6   0:00.07 cpp0                 
  204 root      23   0 17940  11m 8260 R 11.7  4.8   0:02.09 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.35 top                  


top - 23:27:57 up 2 min,  4 users,  load average: 0.33, 0.12, 0.04
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.3% user,  13.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   126244k used,   128772k free,     8764k buffers
Swap:   530108k total,        0k used,   530108k free,    62484k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  287 root      25   0  6796 5284 2860 R 68.4  2.1   0:00.55 cc1                  
  204 root      23   0 17940  11m 8260 R 11.7  4.8   0:02.15 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.36 top                  
  286 root      25   0  2476 1408 1320 R  0.0  0.6   0:00.07 cpp0                 


top - 23:27:58 up 2 min,  4 users,  load average: 0.46, 0.16, 0.05
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  75.0% user,  19.2% system,   0.0% nice,   0.0% idle,   5.8% IO-wait
Mem:    255016k total,   124060k used,   130956k free,     8768k buffers
Swap:   530108k total,        0k used,   530108k free,    62540k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  293 root      25   0  4448 2928 2860 R 29.2  1.1   0:00.15 cc1                  
  292 root      25   0  2452 1532 1320 R 15.6  0.6   0:00.08 cpp0                 
  204 root      23   0 17940  11m 8260 R 13.6  4.8   0:02.22 mplayer              
  203 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.38 top                  


top - 23:27:58 up 2 min,  4 users,  load average: 0.46, 0.16, 0.05
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.2% user,  11.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   126524k used,   128492k free,     8768k buffers
Swap:   530108k total,        0k used,   530108k free,    62540k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  293 root      25   0  6896 5384 2860 R 78.0  2.1   0:00.55 cc1                  
  204 root      23   0 17940  11m 8260 R 13.7  4.8   0:02.29 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.39 top                  
  292 root      25   0  2452 1532 1320 R  0.0  0.6   0:00.08 cpp0                 


top - 23:27:59 up 2 min,  4 users,  load average: 0.46, 0.16, 0.05
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255016k total,   127476k used,   127540k free,     8768k buffers
Swap:   530108k total,        0k used,   530108k free,    62564k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  293 root      25   0  7640 6588 2860 R 80.1  2.6   0:00.96 cc1                  
  204 root      23   0 17940  11m 8260 R 15.6  4.8   0:02.37 mplayer              
  203 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.40 top                  
  292 root      25   0  2452 1532 1320 R  0.0  0.6   0:00.08 cpp0                 


top - 23:27:59 up 2 min,  4 users,  load average: 0.46, 0.16, 0.05
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  82.4% user,  15.7% system,   0.0% nice,   0.0% idle,   2.0% IO-wait
Mem:    255016k total,   122508k used,   132508k free,     8768k buffers
Swap:   530108k total,        0k used,   530108k free,    62612k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  298 root      25   0  2384 1272 1320 R 11.7  0.5   0:00.06 cpp0                 

------=_20030710192749_83559
Content-Type: text/plain; name="toprun-2574mm1.txt"
Content-Disposition: attachment; filename="toprun-2574mm1.txt"

top - 22:43:28 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  38 total,   1 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  12.5% user,   9.7% system,   0.0% nice,  62.4% idle,  15.4% IO-wait
Mem:    254688k total,   183404k used,    71284k free,     9764k buffers
Swap:   530108k total,        0k used,   530108k free,    68584k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  531 root      16   0  1876  960 1764 R  0.0  0.4   0:00.01 top                  


top - 22:43:28 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  38 total,   2 running,  36 sleeping,   0 stopped,   0 zombie
Cpu(s):   2.0% user,   5.9% system,   0.0% nice,  92.2% idle,   0.0% IO-wait
Mem:    254688k total,   183404k used,    71284k free,     9764k buffers
Swap:   530108k total,        0k used,   530108k free,    68588k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  531 root      16   0  1884 1024 1764 R  3.9  0.4   0:00.03 top                  
    1 root      20   0   452  220  420 R  0.0  0.1   0:05.08 init                 


top - 22:43:29 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  39 total,   2 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  25.5% user,  25.5% system,   0.0% nice,  49.0% idle,   0.0% IO-wait
Mem:    254688k total,   190636k used,    64052k free,     9764k buffers
Swap:   530108k total,        0k used,   530108k free,    68588k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      24   0 15796 8632 7964 R 29.4  3.4   0:00.15 mplayer              
  531 root      16   0  1884 1024 1764 R  2.0  0.4   0:00.04 top                  


top - 22:43:30 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  39 total,   2 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  48.1% user,  30.8% system,   0.0% nice,  21.2% idle,   0.0% IO-wait
Mem:    254688k total,   193444k used,    61244k free,     9764k buffers
Swap:   530108k total,        0k used,   530108k free,    68804k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17724  11m 8260 R 29.3  4.7   0:00.30 mplayer              
  531 root      16   0  1884 1024 1764 R  2.0  0.4   0:00.05 top                  


top - 22:43:30 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  39 total,   2 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  19.6% user,  19.6% system,   0.0% nice,  60.8% idle,   0.0% IO-wait
Mem:    254688k total,   193668k used,    61020k free,     9764k buffers
Swap:   530108k total,        0k used,   530108k free,    68804k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R 11.8  4.8   0:00.36 mplayer              
  531 root      16   0  1884 1024 1764 R  2.0  0.4   0:00.06 top                  


top - 22:43:31 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  42.9% user,  22.4% system,   0.0% nice,  26.5% idle,   8.2% IO-wait
Mem:    254688k total,   195668k used,    59020k free,     9764k buffers
Swap:   530108k total,        0k used,   530108k free,    68928k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:00.41 mplayer              
  531 root      16   0  1884 1024 1764 R  2.0  0.4   0:00.07 top                  
  552 root      16   0  1560  624 1320 R  0.0  0.2   0:00.00 cpp0                 


top - 22:43:31 up 2 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  17.3% user,  13.5% system,   0.0% nice,   0.0% idle,  69.2% IO-wait
Mem:    254688k total,   196452k used,    58236k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    69292k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R 11.7  4.8   0:00.47 mplayer              
  552 root      16   0  1980  972 1320 R  7.8  0.4   0:00.04 cpp0                 
  531 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.08 top                  


top - 22:43:32 up 3 min,  4 users,  load average: 0.64, 0.28, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  19.6% user,  13.7% system,   0.0% nice,   0.0% idle,  66.7% IO-wait
Mem:    254688k total,   197012k used,    57676k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    69636k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R 15.6  4.8   0:00.55 mplayer              
  552 root      16   0  2068 1132 1320 R  7.8  0.4   0:00.08 cpp0                 
  531 root      16   0  1888 1028 1764 R  0.0  0.4   0:00.08 top                  


top - 22:43:32 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  21.6% user,  13.7% system,   0.0% nice,   0.0% idle,  64.7% IO-wait
Mem:    254688k total,   197740k used,    56948k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    69992k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R 11.7  4.8   0:00.61 mplayer              
  552 root      16   0  2388 1408 1320 R  9.8  0.6   0:00.13 cpp0                 
  531 root      16   0  1888 1028 1764 R  3.9  0.4   0:00.10 top                  


top - 22:43:33 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  32.7% user,  21.2% system,   0.0% nice,   0.0% idle,  46.2% IO-wait
Mem:    254688k total,   199476k used,    55212k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70328k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  553 root      24   0  3796 2252 2860 R 15.6  0.9   0:00.08 cc1                  
  532 root      25   0 17940  11m 8260 R 11.7  4.8   0:00.67 mplayer              
  531 root      16   0  1888 1028 1764 R  1.9  0.4   0:00.11 top                  


top - 22:43:33 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  84.3% user,  15.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   201828k used,    52860k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70328k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  553 root      25   0  6132 4620 2860 R 68.4  1.8   0:00.43 cc1                  
  532 root      25   0 17940  11m 8260 R 17.6  4.8   0:00.76 mplayer              
  531 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.12 top                  


top - 22:43:34 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.2% user,  11.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   203788k used,    50900k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70328k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  553 root      25   0  8084 6992 2860 R 74.4  2.7   0:00.81 cc1                  
  532 root      25   0 17940  11m 8260 R 13.7  4.8   0:00.83 mplayer              
  531 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.13 top                  


top - 22:43:34 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   4 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  64.7% user,  35.3% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   197124k used,    57564k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70348k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R 15.7  4.8   0:00.91 mplayer              
  531 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.14 top                  
  580 root      24   0  1272  328 1240 R  0.0  0.1   0:00.00 hostname             
  581 root      24   0  1048  600  956 R  0.0  0.2   0:00.00 sh                   


top - 22:43:35 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  61.5% user,  34.6% system,   0.0% nice,   0.0% idle,   3.8% IO-wait
Mem:    254688k total,   199700k used,    54988k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70520k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  603 root      25   0  4028 2488 2860 R 19.5  1.0   0:00.10 cc1                  
  532 root      25   0 17940  11m 8260 R 13.6  4.8   0:00.98 mplayer              
  531 root      16   0  1888 1028 1764 R  1.9  0.4   0:00.15 top                  


top - 22:43:35 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.3% user,  13.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   202052k used,    52636k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70520k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  603 root      25   0  6420 4908 2860 R 78.0  1.9   0:00.50 cc1                  
  532 root      25   0 17940  11m 8260 R 11.7  4.8   0:01.04 mplayer              
  531 root      16   0  1888 1028 1764 R  1.9  0.4   0:00.16 top                  


top - 22:43:36 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  44 total,   3 running,  41 sleeping,   0 stopped,   0 zombie
Cpu(s):  82.4% user,  17.6% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   203788k used,    50900k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70520k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  603 root      25   0  8148 7028 2860 R 68.6  2.8   0:00.85 cc1                  
  532 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.11 mplayer              
  531 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.17 top                  


top - 22:43:36 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  82.0% user,  18.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   198348k used,    56340k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70532k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  606 root      25   0  2012 1264 1356 R 21.6  0.5   0:00.11 make                 
  532 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.18 mplayer              
  531 root      16   0  1888 1028 1764 R  3.9  0.4   0:00.19 top                  
  607 root      25   0  1348  416 1300 R  0.0  0.2   0:00.00 gcc                  


top - 22:43:37 up 3 min,  4 users,  load average: 0.67, 0.29, 0.10
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  73.6% user,  15.1% system,   0.0% nice,   0.0% idle,  11.3% IO-wait
Mem:    254688k total,   202404k used,    52284k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70636k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  609 root      25   0  5160 3640 2860 R 52.7  1.4   0:00.27 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.23 mplayer              
  531 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.19 top                  


top - 22:43:37 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.2% user,  11.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   204700k used,    49988k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70636k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  609 root      25   0  7500 6060 2860 R 76.3  2.4   0:00.66 cc1                  
  532 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.30 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.20 top                  


top - 22:43:38 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  94.0% user,   6.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   205036k used,    49652k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70640k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  609 root      25   0  7808 6764 2860 R 82.2  2.7   0:01.08 cc1                  
  532 root      25   0 17940  11m 8260 R 11.7  4.8   0:01.36 mplayer              
  531 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.22 top                  


top - 22:43:38 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  94.1% user,   5.9% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   205148k used,    49540k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70640k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  609 root      25   0  7764 6724 2860 R 80.2  2.6   0:01.49 cc1                  
  532 root      25   0 17940  11m 8260 R 11.7  4.8   0:01.42 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.23 top                  


top - 22:43:39 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  45 total,   3 running,  42 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   204188k used,    50500k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70640k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  609 root      25   0  7860 6820 2860 R 76.3  2.7   0:01.88 cc1                  
  532 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.49 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.24 top                  


top - 22:43:39 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  82.4% user,  17.6% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   201788k used,    52900k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70672k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  615 root      25   0  4736 3216 2860 R 39.2  1.3   0:00.20 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.54 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.25 top                  


top - 22:43:40 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  45 total,   3 running,  42 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.5% user,  13.5% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   203180k used,    51508k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70672k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  615 root      25   0  7116 6056 2860 R 80.1  2.4   0:00.61 cc1                  
  532 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.61 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.26 top                  


top - 22:43:40 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  76.5% user,  19.6% system,   0.0% nice,   0.0% idle,   3.9% IO-wait
Mem:    254688k total,   202292k used,    52396k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70728k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  621 root      25   0  5012 3492 2860 R 49.0  1.4   0:00.25 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.66 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.27 top                  


top - 22:43:41 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.0% user,  10.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   204700k used,    49988k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70732k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  621 root      25   0  7396 6292 2860 R 84.0  2.5   0:00.68 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.71 mplayer              
  531 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.29 top                  


top - 22:43:41 up 3 min,  4 users,  load average: 0.77, 0.32, 0.11
Tasks:  45 total,   3 running,  42 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.3% user,   7.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   204020k used,    50668k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70732k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  621 root      25   0  7840 6788 2860 R 84.2  2.7   0:01.11 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.76 mplayer              
  531 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.29 top                  


top - 22:43:42 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  78.4% user,  17.6% system,   0.0% nice,   0.0% idle,   3.9% IO-wait
Mem:    254688k total,   201452k used,    53236k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70792k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  627 root      25   0  4272 2744 2860 R 25.5  1.1   0:00.13 cc1                  
  532 root      25   0 17940  11m 8260 R  7.8  4.8   0:01.80 mplayer              
  531 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.31 top                  


top - 22:43:42 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  45 total,   3 running,  42 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   203012k used,    51676k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70792k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  627 root      25   0  6636 5564 2860 R 86.1  2.2   0:00.57 cc1                  
  532 root      25   0 17940  11m 8260 R  7.8  4.8   0:01.84 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.32 top                  


top - 22:43:43 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  80.4% user,  15.7% system,   0.0% nice,   0.0% idle,   3.9% IO-wait
Mem:    254688k total,   202236k used,    52452k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70820k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  633 root      25   0  5072 3552 2860 R 51.0  1.4   0:00.26 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.89 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.33 top                  


top - 22:43:43 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  82.4% user,  17.6% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   201004k used,    53684k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70852k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.94 mplayer              
  639 root      24   0  3596 2032 2860 R  9.8  0.8   0:00.05 cc1                  
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.34 top                  


top - 22:43:44 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   203804k used,    50884k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70856k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  639 root      25   0  6388 4876 2860 R 82.0  1.9   0:00.47 cc1                  
  532 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.99 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.35 top                  


top - 22:43:44 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   198908k used,    55780k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70868k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  531 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.37 top                  
  532 root      25   0 17940  11m 8260 R  3.9  4.8   0:02.01 mplayer              
  641 root      23   0  1044  452  956 R  0.0  0.2   0:00.00 sh                   


top - 22:43:45 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  76.9% user,  21.2% system,   0.0% nice,   0.0% idle,   1.9% IO-wait
Mem:    254688k total,   203188k used,    51500k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70912k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  645 root      25   0  5664 4152 2860 R 64.7  1.6   0:00.33 cc1                  
  532 root      25   0 17940  11m 8260 R  3.9  4.8   0:02.03 mplayer              
  531 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.37 top                  


top - 22:43:45 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   205036k used,    49652k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70912k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  645 root      25   0  7412 6348 2860 R 91.8  2.5   0:00.80 cc1                  
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.38 top                  
  532 root      25   0 17940  11m 8260 R  2.0  4.8   0:02.04 mplayer              


top - 22:43:46 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   3 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):  94.1% user,   5.9% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   205260k used,    49428k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70912k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  645 root      25   0  7548 6496 2860 R 88.1  2.6   0:01.25 cc1                  
  532 root      25   0 17940  11m 8260 R  5.9  4.8   0:02.07 mplayer              
  531 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.39 top                  


top - 22:43:46 up 3 min,  4 users,  load average: 0.87, 0.35, 0.12
Tasks:  46 total,   4 running,  42 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.2% user,  11.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    254688k total,   200164k used,    54524k free,     9772k buffers
Swap:   530108k total,        0k used,   530108k free,    70956k cached

  PID USER      PR  NI  V
------=_20030710192749_83559
Content-Type: text/plain; name="toprun-2574mm2.txt"
Content-Disposition: attachment; filename="toprun-2574mm2.txt"

top - 22:52:13 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  35 total,   1 running,  34 sleeping,   0 stopped,   0 zombie
Cpu(s):  44.1% user,  11.6% system,   0.0% nice,  33.5% idle,  10.8% IO-wait
Mem:    255396k total,   191108k used,    64288k free,     9164k buffers
Swap:   530108k total,        0k used,   530108k free,    82832k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  882 root      17   0  1872  956 1764 R  0.0  0.4   0:00.01 top                  


top - 22:52:13 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  35 total,   1 running,  34 sleeping,   0 stopped,   0 zombie
Cpu(s):   2.0% user,   6.0% system,   0.0% nice,  92.0% idle,   0.0% IO-wait
Mem:    255396k total,   191108k used,    64288k free,     9164k buffers
Swap:   530108k total,        0k used,   530108k free,    82836k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  882 root      17   0  1884 1024 1764 R  3.9  0.4   0:00.03 top                  


top - 22:52:14 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  35 total,   1 running,  34 sleeping,   0 stopped,   0 zombie
Cpu(s):   5.8% user,   7.7% system,   0.0% nice,  86.5% idle,   0.0% IO-wait
Mem:    255396k total,   191108k used,    64288k free,     9164k buffers
Swap:   530108k total,        0k used,   530108k free,    82836k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  882 root      17   0  1884 1024 1764 R  0.0  0.4   0:00.03 top                  


top - 22:52:14 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  36 total,   2 running,  34 sleeping,   0 stopped,   0 zombie
Cpu(s):  59.6% user,  33.3% system,   0.0% nice,   7.0% idle,   0.0% IO-wait
Mem:    255396k total,   200588k used,    54808k free,     9164k buffers
Swap:   530108k total,        0k used,   530108k free,    82836k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  883 root      21   0 17292  11m 8044 R 49.8  4.5   0:00.29 mplayer              
  882 root      16   0  1884 1024 1764 R  1.7  0.4   0:00.04 top                  


top - 22:52:15 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  36 total,   2 running,  34 sleeping,   0 stopped,   0 zombie
Cpu(s):  17.6% user,  15.7% system,   0.0% nice,  66.7% idle,   0.0% IO-wait
Mem:    255396k total,   201260k used,    54136k free,     9164k buffers
Swap:   530108k total,        0k used,   530108k free,    83052k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  883 root      23   0 17940  11m 8260 R  9.8  4.8   0:00.34 mplayer              
  882 root      17   0  1884 1024 1764 R  3.9  0.4   0:00.06 top                  


top - 22:52:15 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  36 total,   3 running,  33 sleeping,   0 stopped,   0 zombie
Cpu(s):  22.6% user,  15.1% system,   0.0% nice,  62.3% idle,   0.0% IO-wait
Mem:    255396k total,   201260k used,    54136k free,     9164k buffers
Swap:   530108k total,        0k used,   530108k free,    83052k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  883 root      24   0 17940  11m 8260 R 13.7  4.8   0:00.41 mplayer              
  112 root      16   0  2484 1048 2340 R  3.9  0.4   0:00.86 xsnow                
  882 root      16   0  1884 1024 1764 R  0.0  0.4   0:00.06 top                  


top - 22:52:16 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  41 total,   3 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  52.9% user,  25.5% system,   0.0% nice,  17.6% idle,   3.9% IO-wait
Mem:    255396k total,   203764k used,    51632k free,     9168k buffers
Swap:   530108k total,        0k used,   530108k free,    83072k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  903 root      24   0  2324 1288 1320 R 11.7  0.5   0:00.06 cpp0                 
  883 root      24   0 17940  11m 8260 R  9.7  4.8   0:00.46 mplayer              
  882 root      16   0  1884 1024 1764 R  3.9  0.4   0:00.08 top                  


top - 22:52:17 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  41 total,   3 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  62.7% user,  13.7% system,   0.0% nice,   0.0% idle,  23.5% IO-wait
Mem:    255396k total,   206340k used,    49056k free,     9168k buffers
Swap:   530108k total,        0k used,   530108k free,    83288k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  904 root      25   0  4820 3300 2860 R 41.1  1.3   0:00.21 cc1                  
  883 root      25   0 17940  11m 8260 R 15.7  4.8   0:00.54 mplayer              
  882 root      16   0  1888 1028 1764 R  0.0  0.4   0:00.08 top                  


top - 22:52:17 up 3 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  41 total,   3 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.3% user,  13.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   208692k used,    46704k free,     9168k buffers
Swap:   530108k total,        0k used,   530108k free,    83288k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  904 root      25   0  7128 5616 2860 R 76.5  2.2   0:00.60 cc1                  
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:00.60 mplayer              
  882 root      16   0  1888 1028 1764 R  3.9  0.4   0:00.10 top                  


top - 22:52:18 up 4 min,  4 users,  load average: 1.40, 0.75, 0.28
Tasks:  38 total,   3 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.3% user,  13.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   202564k used,    52832k free,     9168k buffers
Swap:   530108k total,        0k used,   530108k free,    83300k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  883 root      25   0 17940  11m 8260 R 15.7  4.8   0:00.68 mplayer              
  882 root      16   0  1888 1028 1764 R  0.0  0.4   0:00.10 top                  
  906 root      22   0  1044  616  956 R  0.0  0.2   0:00.00 sh                   


top - 22:52:18 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  41 total,   4 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  52.9% user,  43.1% system,   0.0% nice,   0.0% idle,   3.9% IO-wait
Mem:    255396k total,   204548k used,    50848k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83440k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  953 root      25   0  2880 1628 1320 R 19.6  0.6   0:00.10 cpp0                 
  883 root      25   0 17940  11m 8260 R 13.7  4.8   0:00.75 mplayer              
  882 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.11 top                  
  954 root      25   0  3188 1572 2860 R  2.0  0.6   0:00.01 cc1                  


top - 22:52:19 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  41 total,   4 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  82.0% user,  18.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   207012k used,    48384k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83440k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  954 root      25   0  5640 4128 2860 R 68.5  1.6   0:00.36 cc1                  
  883 root      25   0 17940  11m 8260 R 17.6  4.8   0:00.84 mplayer              
  882 root      16   0  1888 1028 1764 R  3.9  0.4   0:00.13 top                  
  953 root      25   0  2880 1628 1320 R  0.0  0.6   0:00.10 cpp0                 


top - 22:52:19 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  41 total,   4 running,  37 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.5% user,  13.5% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   209084k used,    46312k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83440k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  954 root      25   0  7716 6204 2860 R 74.1  2.4   0:00.74 cc1                  
  883 root      25   0 17940  11m 8260 R 13.6  4.8   0:00.91 mplayer              
  882 root      16   0  1888 1028 1764 R  0.0  0.4   0:00.13 top                  
  953 root      25   0  2880 1628 1320 R  0.0  0.6   0:00.10 cpp0                 


top - 22:52:20 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  38 total,   3 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s):  84.3% user,  15.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   203236k used,    52160k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83456k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  956 root      22   0  1980 1152 1356 R 13.7  0.5   0:00.07 make                 
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:00.97 mplayer              
  882 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.14 top                  


top - 22:52:20 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  70.6% user,  25.5% system,   0.0% nice,   0.0% idle,   3.9% IO-wait
Mem:    255396k total,   206692k used,    48704k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83524k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  883 root      25   0 17940  11m 8260 R 15.7  4.8   0:01.05 mplayer              
  960 root      25   0  3748 2200 2860 R 13.8  0.9   0:00.07 cc1                  
  882 root      16   0  1888 1028 1764 R  3.9  0.4   0:00.16 top                  


top - 22:52:21 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.3% user,  13.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   209100k used,    46296k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83524k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  883 root      25   0 17940  11m 8260 R 11.7  4.8   0:01.11 mplayer              
  882 root      16   0  1888 1028 1764 R  2.0  0.4   0:00.17 top                  
  959 root      25   0  2728 1528 1320 R  0.0  0.6   0:00.10 cpp0                 


top - 22:52:21 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  80.8% user,  19.2% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   210500k used,    44896k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83524k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  960 root      25   0  7588 6388 2860 R 56.9  2.5   0:00.72 cc1                  
  883 root      25   0 17940  11m 8260 R 15.7  4.8   0:01.19 mplayer              
  882 root      16   0  1888 1028 1764 R  0.0  0.4   0:00.17 top                  


top - 22:52:22 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   210724k used,    44672k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83524k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  960 root      25   0  7808 6764 2860 R 74.5  2.6   0:01.10 cc1                  
  883 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.26 mplayer              
  882 root      16   0  1888 1028 1764 R  3.9  0.4   0:00.19 top                  


top - 22:52:22 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  94.0% user,   6.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   210836k used,    44560k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83524k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  960 root      25   0  7708 6664 2860 R 68.6  2.6   0:01.45 cc1                  
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:01.32 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.20 top                  


top - 22:52:23 up 4 min,  4 users,  load average: 1.61, 0.80, 0.30
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.3% user,   7.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   209876k used,    45520k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83528k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  960 root      25   0  7860 6820 2860 R 74.4  2.7   0:01.83 cc1                  
  883 root      25   0 17940  11m 8260 R 11.7  4.8   0:01.38 mplayer              
  100 root      15  -1 58944  13m  45m R  7.8  5.5   0:11.10 X                    
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.21 top                  


top - 22:52:23 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  84.0% user,  16.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   206748k used,    48648k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83560k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  966 root      23   0  3940 2396 2860 R 17.6  0.9   0:00.09 cc1                  
  965 root      24   0  2476 1408 1320 R 15.7  0.6   0:00.08 cpp0                 
  883 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.43 mplayer              
  882 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.21 top                  


top - 22:52:24 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.5% user,  11.5% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   208820k used,    46576k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83560k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  966 root      25   0  6024 4512 2860 R 60.7  1.8   0:00.40 cc1                  
  883 root      25   0 17940  11m 8260 R 19.6  4.8   0:01.53 mplayer              
  882 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.23 top                  


top - 22:52:24 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  80.0% user,  18.0% system,   0.0% nice,   0.0% idle,   2.0% IO-wait
Mem:    255396k total,   206076k used,    49320k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83600k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  971 root      24   0  2452 1532 1320 R 17.7  0.6   0:00.09 cpp0                 
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:01.59 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.24 top                  
  972 root      22   0  3160 1544 2860 R  2.0  0.6   0:00.01 cc1                  


top - 22:52:25 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   208820k used,    46576k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83600k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  972 root      25   0  5912 4400 2860 R 74.4  1.7   0:00.39 cc1                  
  883 root      25   0 17940  11m 8260 R 13.7  4.8   0:01.66 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.25 top                  


top - 22:52:25 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.2% user,   9.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   210444k used,    44952k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83604k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  972 root      25   0  7536 6464 2860 R 70.6  2.5   0:00.75 cc1                  
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:01.72 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.26 top                  
  112 root      15   0  2484 1048 2340 R  0.0  0.4   0:00.97 xsnow                


top - 22:52:26 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  42 total,   4 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.3% user,   7.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   209708k used,    45688k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83604k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  972 root      25   0  7920 6864 2860 R 76.5  2.7   0:01.14 cc1                  
  100 root      15  -1 58944  13m  45m R 11.8  5.5   0:11.42 X                    
  883 root      25   0 17940  11m 8260 R  7.8  4.8   0:01.76 mplayer              
  882 root      15   0  1888 1028 1764 R  0.0  0.4   0:00.26 top                  


top - 22:52:26 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  84.0% user,  16.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   207196k used,    48200k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83628k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  978 root      24   0  4468 2948 2860 R 31.4  1.2   0:00.16 cc1                  
  883 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.81 mplayer              
  882 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.28 top                  


top - 22:52:27 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  42 total,   3 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.5% user,  13.5% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   208588k used,    46808k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83628k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  978 root      25   0  6600 5516 2860 R 72.4  2.2   0:00.53 cc1                  
  883 root      25   0 17940  11m 8260 R  9.8  4.8   0:01.86 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.29 top                  


top - 22:52:27 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  78.4% user,  19.6% system,   0.0% nice,   0.0% idle,   2.0% IO-wait
Mem:    255396k total,   207532k used,    47864k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83656k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  984 root      24   0  4808 3288 2860 R 39.2  1.3   0:00.20 cc1                  
  100 root      15  -1 58944  13m  45m R 11.8  5.5   0:11.59 X                    
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:01.92 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.30 top                  


top - 22:52:28 up 4 min,  4 users,  load average: 1.64, 0.82, 0.31
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  86.3% user,  13.7% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   205796k used,    49600k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83684k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  989 root      22   0  2380 1256 1320 R  9.7  0.5   0:00.05 cpp0                 
  883 root      25   0 17940  11m 8260 R  5.8  4.8   0:01.95 mplayer              
  112 root      15   0  2484 1048 2340 R  1.9  0.4   0:01.00 xsnow                
  882 root      15   0  1888 1028 1764 R  1.9  0.4   0:00.31 top                  


top - 22:52:28 up 4 min,  4 users,  load average: 1.67, 0.84, 0.32
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.5% user,  11.5% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   208764k used,    46632k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83692k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  990 root      25   0  5736 4224 2860 R 70.5  1.7   0:00.36 cc1                  
  883 root      25   0 17940  11m 8260 R 11.7  4.8   0:02.01 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.32 top                  


top - 22:52:29 up 4 min,  4 users,  load average: 1.67, 0.84, 0.32
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.0% user,  10.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   210444k used,    44952k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83692k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  990 root      25   0  7600 6412 2860 R 72.6  2.5   0:00.73 cc1                  
  883 root      25   0 17940  11m 8260 R 11.8  4.8   0:02.07 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.33 top                  


top - 22:52:29 up 4 min,  4 users,  load average: 1.67, 0.84, 0.32
Tasks:  43 total,   4 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  80.4% user,  13.7% system,   0.0% nice,   0.0% idle,   5.9% IO-wait
Mem:    255396k total,   206916k used,    48480k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83748k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  995 root      24   0  2412 1520 1320 R 17.6  0.6   0:00.09 cpp0                 
  996 root      23   0  3852 2308 2860 R 15.7  0.9   0:00.08 cc1                  
  883 root      25   0 17940  11m 8260 R  3.9  4.8   0:02.09 mplayer              
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.34 top                  


top - 22:52:30 up 4 min,  4 users,  load average: 1.67, 0.84, 0.32
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  90.4% user,   9.6% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   209772k used,    45624k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83748k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  996 root      25   0  6700 5188 2860 R 90.0  2.0   0:00.54 cc1                  
  882 root      15   0  1888 1028 1764 R  3.9  0.4   0:00.36 top                  
  883 root      25   0 17940  11m 8260 R  3.9  4.8   0:02.11 mplayer              


top - 22:52:30 up 4 min,  4 users,  load average: 1.67, 0.84, 0.32
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  92.2% user,   7.8% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   210780k used,    44616k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83748k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  996 root      25   0  7548 6496 2860 R 92.2  2.5   0:01.01 cc1                  
  882 root      15   0  1888 1028 1764 R  2.0  0.4   0:00.37 top                  
  883 root      25   0 17940  11m 8260 R  2.0  4.8   0:02.12 mplayer              


top - 22:52:31 up 4 min,  4 users,  load average: 1.67, 0.84, 0.32
Tasks:  42 total,   3 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  96.0% user,   4.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    255396k total,   209764k used,    45632k free,     9172k buffers
Swap:   530108k total,        0k used,   530108k free,    83748k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command              
  996 root      25   0  7776 6724 2860 R 86.3  2.6   0

------=_20030710192749_83559--

