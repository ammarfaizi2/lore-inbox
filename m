Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSLAI7u>; Sun, 1 Dec 2002 03:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSLAI7u>; Sun, 1 Dec 2002 03:59:50 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:7698 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S261545AbSLAI7s>; Sun, 1 Dec 2002 03:59:48 -0500
Date: Sun, 1 Dec 2002 20:07:10 +1100 (EST)
From: Tim Connors <tconnors@astro.swin.edu.au>
X-X-Sender: <tconnors@hexane.ssi.swin.edu.au>
To: William Lee Irwin III <wli@holomorphy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: small memory machine, large reserved memory
In-Reply-To: <20021104021509.GS23425@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0212012005150.3187-200000@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1165488628-859046639-1038733630=:3187"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1165488628-859046639-1038733630=:3187
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 3 Nov 2002, William Lee Irwin III wrote:

> On Mon, Nov 04, 2002 at 01:10:36PM +1100, Tim Connors wrote:
> > In light of the recent discussions about config_tiny, etc, I decided to
> > install 2.4.19 on my old 8MB 486, to see whether it performed any better
> > than my previous attempts with 2.2.* and 2.4.*
> > The strange thing is, the memory init line at bootup (eg Memory:
> > 255296k/261996k available (1584k kernel code, 5972k reserved, 1353k data
> > , 108k init, 0k highmem)) says that only about 5 or 6MB are availabel,
> > with a whopping 2.x MB reserved. I have done a web search, and the only
> > answer I have come up with is that the top 384kb of the 1MB lower
> > portion of RAM should be here, but what else could be eating up all my
> > RAM?
> > There is nothgin suspicious in the BIOS - all BIOS and video caching is
> > turned off. The machine only (natually) has ISA slots in it, most are
> > empty. What else could possibly be wrong?
> > Is there something I can hack in the kernel to get it to use that, or can
> > anyone give me pointers as to what else I can change? I would really love
> > to regain that 2MB - its a pain when the shell gets swapped out after
> > doing an `ls` :)
>
> How does 2.5.44 (or 2.5.x-bk) do?

Okie dokie. Finally booted it and remembered to record the dmesg.

Is attached.

So any idea's on who is stealing my 2 Megs RAM? BIOS's fault?


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

                  -o)
                  /\\    The penguins are coming...
                 _\_v       the penguins are coming...

---1165488628-859046639-1038733630=:3187
Content-Type: TEXT/plain; name="feynman.boot-log.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0212012007100.3187@hexane.ssi.swin.edu.au>
Content-Description: 
Content-Disposition: attachment; filename="feynman.boot-log.txt"

TGludXggdmVyc2lvbiAyLjUuNDUgKHJvb3RAc2N1enppZSkgKGdjYyB2ZXJz
aW9uIDIuOTUuNCAyMDAxMTAwMiAoRGViaWFuIHByZXJlbGVhc2UpKSAjOCBU
dWUgTm92IDUgMjM6MDQ6MzEgRVNUIDIwMDINClZpZGVvIG1vZGUgdG8gYmUg
dXNlZCBmb3IgcmVzdG9yZSBpcyBmMDENCkJJT1MtcHJvdmlkZWQgcGh5c2lj
YWwgUkFNIG1hcDoNCiBCSU9TLTg4OiAwMDAwMDAwMDAwMDAwMDAwIC0gMDAw
MDAwMDAwMDA5ZjAwMCAodXNhYmxlKQ0KIEJJT1MtODg6IDAwMDAwMDAwMDAx
MDAwMDAgLSAwMDAwMDAwMDAwODAwMDAwICh1c2FibGUpDQo4TUIgTE9XTUVN
IGF2YWlsYWJsZS4NCk9uIG5vZGUgMCB0b3RhbHBhZ2VzOiAyMDQ4DQogIERN
QSB6b25lOiAyMDQ4IHBhZ2VzLCBMSUZPIGJhdGNoOjENCiAgTm9ybWFsIHpv
bmU6IDAgcGFnZXMsIExJRk8gYmF0Y2g6MQ0KICBIaWdoTWVtIHpvbmU6IDAg
cGFnZXMsIExJRk8gYmF0Y2g6MQ0KQnVpbGRpbmcgem9uZWxpc3QgZm9yIG5v
ZGUgOiAwDQpLZXJuZWwgY29tbWFuZCBsaW5lOiBCT09UX0lNQUdFPWxpbnV4
MjU0NSBybyByb290PTMwNg0KSW5pdGlhbGl6aW5nIENQVSMwDQpDb25zb2xl
OiBjb2xvdXIgVkdBKyA4MHg1MA0KQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4u
LiAxNS44NCBCb2dvTUlQUw0KTWVtb3J5OiA0OTUyay84MTkyayBhdmFpbGFi
bGUgKDE0NTJrIGtlcm5lbCBjb2RlLCAyODI4ayByZXNlcnZlZCwgODYxayBk
YXRhLCA5MmsgaW5pdCwgMGsgaGlnaG1lbSkNCkNoZWNraW5nIGlmIHRoaXMg
cHJvY2Vzc29yIGhvbm91cnMgdGhlIFdQIGJpdCBldmVuIGluIHN1cGVydmlz
b3IgbW9kZS4uLiBPay4NClNlY3VyaXR5IFNjYWZmb2xkIHYxLjAuMCBpbml0
aWFsaXplZA0KRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTAy
NCAob3JkZXI6IDEsIDgxOTIgYnl0ZXMpDQpJbm9kZS1jYWNoZSBoYXNoIHRh
YmxlIGVudHJpZXM6IDUxMiAob3JkZXI6IDAsIDQwOTYgYnl0ZXMpDQpNb3Vu
dC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3JkZXI6IDAsIDQw
OTYgYnl0ZXMpDQpDUFU6IEJlZm9yZSB2ZW5kb3IgaW5pdCwgY2FwczogMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAsIHZlbmRvciA9IDI1NQ0KQ1BVOiBB
ZnRlciB2ZW5kb3IgaW5pdCwgY2FwczogMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDANCkNQVTogICAgIEFmdGVyIGdlbmVyaWMsIGNhcHM6
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQpDUFU6ICAg
ICAgICAgICAgIENvbW1vbiBjYXBzOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMA0KQ1BVOiA0ODYNCkNoZWNraW5nICdobHQnIGluc3Ry
dWN0aW9uLi4uIE9LLg0KUE9TSVggY29uZm9ybWFuY2UgdGVzdGluZyBieSBV
TklGSVgNCkxpbnV4IE5FVDQuMCBmb3IgTGludXggMi40DQpCYXNlZCB1cG9u
IFN3YW5zZWEgVW5pdmVyc2l0eSBDb21wdXRlciBTb2NpZXR5IE5FVDMuMDM5
DQpJbml0aWFsaXppbmcgUlQgbmV0bGluayBzb2NrZXQNCm10cnI6IHYyLjAg
KDIwMDIwNTE5KQ0KTGludXggUGx1ZyBhbmQgUGxheSBTdXBwb3J0IHYwLjkg
KGMpIEFkYW0gQmVsYXkNClJlZ2lzdGVyaW5nIHN5c3RlbSBkZXZpY2UgY3B1
MA0KYWRkaW5nICcnIHRvIGNwdSBjbGFzcyBpbnRlcmZhY2VzDQpCSU86IHBv
b2wgb2YgMjU2IHNldHVwLCAxNEtiICg1NiBieXRlcy9iaW8pDQpiaW92ZWMg
cG9vbFswXTogICAxIGJ2ZWNzOiAgIDQgZW50cmllcyAoMTIgYnl0ZXMpDQpi
aW92ZWMgcG9vbFsxXTogICA0IGJ2ZWNzOiAgIDIgZW50cmllcyAoNDggYnl0
ZXMpDQpiaW92ZWMgcG9vbFsyXTogIDE2IGJ2ZWNzOiAgIDEgZW50cmllcyAo
MTkyIGJ5dGVzKQ0KYmlvdmVjIHBvb2xbM106ICA2NCBidmVjczogICAwIGVu
dHJpZXMgKDc2OCBieXRlcykNCmJpb3ZlYyBwb29sWzRdOiAxMjggYnZlY3M6
ICAgMCBlbnRyaWVzICgxNTM2IGJ5dGVzKQ0KYmlvdmVjIHBvb2xbNV06IDI1
NiBidmVjczogICAwIGVudHJpZXMgKDMwNzIgYnl0ZXMpDQppc2FwbnA6IFNj
YW5uaW5nIGZvciBQblAgY2FyZHMuLi4NCmlzYXBucDogQ2FyZCAnSW50ZWwg
UFJPLzEwKyBvciBjb21wYXRpYmxlIGFkYXB0ZXInDQppc2FwbnA6IDEgUGx1
ZyAmIFBsYXkgY2FyZCBkZXRlY3RlZCB0b3RhbA0KUmVnaXN0ZXJpbmcgc3lz
dGVtIGRldmljZSBwaWMwDQpSZWdpc3RlcmluZyBzeXN0ZW0gZGV2aWNlIHJ0
YzANCmFwbTogQklPUyBub3QgZm91bmQuDQpzbGFiOiByZWFwIHRpbWVyIHN0
YXJ0ZWQgZm9yIGNwdSAwDQpTdGFydGluZyBrc3dhcGQNCmFpb19zZXR1cDog
c2l6ZW9mKHN0cnVjdCBwYWdlKSA9IDQwDQpKb3VybmFsbGVkIEJsb2NrIERl
dmljZSBkcml2ZXIgbG9hZGVkDQpJbnN0YWxsaW5nIGtuZnNkIChjb3B5cmln
aHQgKEMpIDE5OTYgb2tpckBtb25hZC5zd2IuZGUpLg0KQ2FwYWJpbGl0eSBM
U00gaW5pdGlhbGl6ZWQNClNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIgJFJl
dmlzaW9uOiAxLjkwICQgSVJRIHNoYXJpbmcgZGlzYWJsZWQNCnR0eVMwIGF0
IEkvTyAweDNmOCAoaXJxID0gNCkgaXMgYSAxNjQ1MA0KdHR5UzEgYXQgSS9P
IDB4MmY4IChpcnEgPSAzKSBpcyBhIDE2NDUwDQpwdHk6IDI1NiBVbml4OTgg
cHR5cyBjb25maWd1cmVkDQpbYzAzYmUwMzBdIGV2ZW50cG9sbDogZHJpdmVy
IGluc3RhbGxlZC4NCkdlbmVyaWMgUlRDIERyaXZlciB2MS4wNg0KYmxvY2sg
cmVxdWVzdCBxdWV1ZXM6DQogMTYgcmVxdWVzdHMgcGVyIHJlYWQgcXVldWUN
CiAxNiByZXF1ZXN0cyBwZXIgd3JpdGUgcXVldWUNCiAyIHJlcXVlc3RzIHBl
ciBiYXRjaA0KIGVudGVyIGNvbmdlc3Rpb24gYXQgMw0KIGV4aXQgY29uZ2Vz
dGlvbiBhdCA1DQpGbG9wcHkgZHJpdmUocyk6IGZkMCBpcyAxLjQ0TSwgZmQx
IGlzIDEuMk0NCkZEQyAwIGlzIGFuIDgyNzJBDQpVbmlmb3JtIE11bHRpLVBs
YXRmb3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjogNy4wMGFscGhhMg0KaWRl
OiBBc3N1bWluZyA1ME1IeiBzeXN0ZW0gYnVzIHNwZWVkIGZvciBQSU8gbW9k
ZXM7IG92ZXJyaWRlIHdpdGggaWRlYnVzPXh4DQpoZGE6IENvbm5lciBQZXJp
cGhlcmFscyAyMTEzTUIgLSBDRkEyMTYxQSwgQVRBIERJU0sgZHJpdmUNCmhk
YjogUGlvbmVlciBDRC1ST00gQVRBUElNb2RlbCBEUi1VQTEyNFggMDEwLCBB
VEFQSSBDRC9EVkQtUk9NIGRyaXZlDQppZGUwIGF0IDB4MWYwLTB4MWY3LDB4
M2Y2IG9uIGlycSAxNA0KaGRhOiB0YXNrX25vX2RhdGFfaW50cjogc3RhdHVz
PTB4NTEgeyBEcml2ZVJlYWR5IFNlZWtDb21wbGV0ZSBFcnJvciB9DQpoZGE6
IHRhc2tfbm9fZGF0YV9pbnRyOiBlcnJvcj0weDA0IHsgRHJpdmVTdGF0dXNF
cnJvciB9DQpoZGE6IDQxMjc3NjAgc2VjdG9ycyAoMjExMyBNQiksIENIUz00
MDk1LzE2LzYzDQogaGRhOiBoZGExIGhkYTIgPCBoZGE1IGhkYTYgPg0KZW5k
X3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IDAzOjQwLCBzZWN0b3IgMA0KaGRi
OiBBVEFQSSA0WCBDRC1ST00gZHJpdmUsIDEyOGtCIENhY2hlDQpVbmlmb3Jt
IENELVJPTSBkcml2ZXIgUmV2aXNpb246IDMuMTINCmVuZF9yZXF1ZXN0OiBJ
L08gZXJyb3IsIGRldiAwMzo0MCwgc2VjdG9yIDANClNDU0kgc3Vic3lzdGVt
IGRyaXZlciBSZXZpc2lvbjogMS4wMA0Kc2NzaTAgOiBTQ1NJIGhvc3QgYWRh
cHRlciBlbXVsYXRpb24gZm9yIElERSBBVEFQSSBkZXZpY2VzDQpyZWdpc3Rl
ciBpbnRlcmZhY2UgJ21vdXNlJyB3aXRoIGNsYXNzICdpbnB1dA0KbWljZTog
UFMvMiBtb3VzZSBkZXZpY2UgY29tbW9uIGZvciBhbGwgbWljZQ0KaW5wdXQ6
IFBDIFNwZWFrZXINCmlucHV0OiBBVCBTZXQgMiBrZXlib2FyZCBvbiBpc2Ew
MDYwL3NlcmlvMA0Kc2VyaW86IGk4MDQyIEtCRCBwb3J0IGF0IDB4NjAsMHg2
NCBpcnEgMQ0KTkVUNDogTGludXggVENQL0lQIDEuMCBmb3IgTkVUNC4wDQpJ
UDogcm91dGluZyBjYWNoZSBoYXNoIHRhYmxlIG9mIDUxMiBidWNrZXRzLCA0
S2J5dGVzDQpUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlz
aGVkIDUxMiBiaW5kIDUxMikNCmlwX2Nvbm50cmFjayB2ZXJzaW9uIDIuMSAo
NjQgYnVja2V0cywgNTEyIG1heCkgLSAyOTYgYnl0ZXMgcGVyIGNvbm50cmFj
aw0KTkVUNDogVW5peCBkb21haW4gc29ja2V0cyAxLjAvU01QIGZvciBMaW51
eCBORVQ0LjAuDQpWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MiBmaWxlc3lzdGVt
KSByZWFkb25seS4NCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDky
ayBmcmVlZA0Kc3B1cmlvdXMgODI1OUEgaW50ZXJydXB0OiBJUlE3Lg0KQWRk
aW5nIDY1OTg0ayBzd2FwIG9uIC9kZXYvaGRhNS4gIFByaW9yaXR5Oi0xIGV4
dGVudHM6MQ0KbmUuYzp2MS4xMCA5LzIzLzk0IERvbmFsZCBCZWNrZXIgKGJl
Y2tlckBzY3lsZC5jb20pDQpMYXN0IG1vZGlmaWVkIE5vdiAxLCAyMDAwIGJ5
IFBhdWwgR29ydG1ha2VyDQpORSowMDAgZXRoZXJjYXJkIHByb2JlIGF0IDB4
MzIwOiAwMCA0MCAzMyAyNSAwYSAzOA0KZXRoMDogTkUyMDAwIGZvdW5kIGF0
IDB4MzIwLCB1c2luZyBJUlEgMTIuDQo=
---1165488628-859046639-1038733630=:3187--
