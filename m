Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265503AbRF1Dkr>; Wed, 27 Jun 2001 23:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265505AbRF1Dkh>; Wed, 27 Jun 2001 23:40:37 -0400
Received: from mail.aslab.com ([205.219.89.194]:16144 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S265503AbRF1DkR>;
	Wed, 27 Jun 2001 23:40:17 -0400
Date: Wed, 27 Jun 2001 20:39:45 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, Gunther.Mayer@t-online.de,
        dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <UTC200106280105.DAA331227.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.04.10106271959510.25404-200000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1212088808-1292345401-993699585=:25404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1212088808-1292345401-993699585=:25404
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 28 Jun 2001 Andries.Brouwer@cwi.nl wrote:

>     From: Andre Hedrick <andre@aslab.com>
> 
>     You know yourself first and all the screwed up ATAPI products that are
>     still using SFF-8020 that has been obsoleted before I start maintaining
>     the subsystem three plus years ago. 
> 
> Hi Andre -
> 
> Why precisely is complying to SFF-8020 broken?
> That was the standard. The standard that Microsoft required.

You have stated it clearly it is past tense.

> Other people made a different standard, and claimed that theirs
> was better or more official or whatever, but reality is that
> the products were not manufactured following this so-called
> better standard.

Ignoring "junk hardware" is not practical it will bite you everyday all
day long.........Best example is VIA.

> You are a good disciple of Hale, but it is no use ignoring the

If one is going to learn the rules it is best to have learned from on of
the "Fathers of ATA", and given that I have been crowned "Hale Jr." I take
this a compliment.  The reality is that I am not anywhere in the same
class of understanding as Hale Landis, but getting there.

> fact that a very large number of devices was made following SFF-8020.
> These devices are not necessarily screwed, they tend to work fine,
> although both ATA and ATAPI devices have their quirks.

If they all did the same thing (regardless of class) it would be a
different issue.  Basic things like asking for N amounts of data and
getting back N+M > N the buffer allocated.  Or worse is the under
data-run.  Other issues are DRQ, failure to hold/set busy-bit.

The ATAPI people do not even follow the rules in the defunct guide.

> SFF-8020, later INF-8020, became part of ATA/ATAPI-4 (1998).
> The T13 people that merged SFF-8020 and produced ATA/ATAPI-4
> changed a few details about how a master is supposed to react
> when a nonexistent slave is selected. Nobody really noticed,

That point is only important during POST and execution of drive
diagnostics command and Linux does not call that command.

> and ATA/ATAPI-5 still had the same requirements. But then long
> discussions about this difference caused ATA/ATAPI-6 to go back
> to the original SFF-8020 requirements. Do you disagree with this
> description of history? If you agree then it is not SFF-8020
> but ATA/ATAPI-4 and ATA/ATAPI-5 that today must be considered broken
> in this respect. I am referring to Section 9.16.1 of these standards.
> 
> Maybe there are other things in SFF-8020 that you consider broken?

See above, regardless of the brokeness whe have to mucky with it.
So I move to develop to a standard that I have influence and direction
control, then deal with the exceptions.

ATA-X created the "packet-command" and "data-phase-handlers" based on the
zero-bit in the error_feature task-register.

Lastly it does not exist anymore, a real problem for manufacturers
building product on a document that does not exist.  Worse is that there
are companies making hardware based on SFF-8020 v2.5!

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com


---1212088808-1292345401-993699585=:25404
Content-Type: TEXT/plain; name="inf-8020.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.04.10106272039450.25404@mail.aslab.com>
Content-Description: 
Content-Disposition: attachment; filename="inf-8020.txt"

RXhwaXJlZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTRkYtODAyMGkgUmV2IDIuNiANDQoNDQoNDQpT
RkYgQ29tbWl0dGVlIGRvY3VtZW50YXRpb24gbWF5IGJlIHB1cmNoYXNlZCAo
c2VlIHA0KS4NDQpTRkYgQ29tbWl0dGVlIGRvY3VtZW50cyBhcmUgYXZhaWxh
YmxlIGJ5IEZheEFjY2VzcyBhdCA0MDgtNzQxLTE2MDANDQoNDQoNDQoNDQoN
DQoNDQoNDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNGRiBD
b21taXR0ZWUNDQoNDQogICAgICAgICAgICAgICAgICAgICAgICAgIFNGRi04
MDIwaSBTcGVjaWZpY2F0aW9uIGZvciANDQoNDQogICAgICAgICAgICAgICAg
ICAgICAgQVRBIFBhY2tldCBJbnRlcmZhY2UgZm9yIENELVJPTSANDQoNDQog
ICAgICAgICAgICAgICAgICAgICAgICAgIFJldiAyLjYgICBKYW51YXJ5IDIy
LCAxOTk2DQ0KDQ0KDQ0KDQ0KU2VjcmV0YXJpYXQ6ICBTRkYgQ29tbWl0dGVl
DQ0KDQ0KDQ0KQWJzdHJhY3Q6ICBJTkYtODAyMGkgZGVmaW5lcyBkZWZpbmVz
IGEgUGFja2V0IEludGVyZmFjZSBmb3IgdXNlIHdpdGggQ0QtUk9NIA0NCmRy
aXZlcyB0aGF0IHVzZSB0aGUgQVRBIChBVCBBdHRhY2htZW50KSBpbnRlcmZh
Y2UuDQ0KDQ0KVGhlIG1lbWJlcnMgdm90ZWQgaW4gU2VwdGVtYmVyIDE5OTkg
dGhhdCB0aGlzIHNwZWNpZmljYXRpb24gRXhwaXJlLiANDQoNDQpTRkYtODAy
MCBoYXMgYmVlbiBpbmNvcnBvcmF0ZWQgaW50byB0d28gbmF0aW9uYWwgc3Rh
bmRhcmRzLCBTQ1NJIE1NQyAoTXVsdGkgDQ0KTWVkaWEgQ29tbWFuZHMpIGFu
ZCBBVEEvQVRBUEkgKEFUIEF0dGFjaG1lbnQpLiANDQoNDQpGb3IgY3VycmVu
dCBpbmZvcm1hdGlvbiwgc2VlOg0NCg0NCiAtIHd3dy50MTAub3JnIGZvciB0
aGUgbGF0ZXN0IHJldmlzaW9uIG9mIFNDU0kgTU1DLXggDQ0KIC0gd3d3LnQx
My5vcmcgZm9yIHRoZSBsYXRlc3QgcmV2aXNpb24gb2YgQVRBL0FUQVBJLXgN
DQoNDQo=
---1212088808-1292345401-993699585=:25404--
