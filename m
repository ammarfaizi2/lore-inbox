Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTAAWkf>; Wed, 1 Jan 2003 17:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbTAAWke>; Wed, 1 Jan 2003 17:40:34 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:44722 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S265099AbTAAWkb>; Wed, 1 Jan 2003 17:40:31 -0500
Message-ID: <20030101224854.38161.qmail@mail.com>
Content-Type: multipart/mixed; boundary="----------=_1041461333-4971-2"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "marijn ros" <marijn@mad.scientist.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 01 Jan 2003 17:48:53 -0500
Subject: [Documentation PATCH] Re: 2.4.21-pre2 IDE problems
X-Originating-Ip: 131.211.221.214
X-Originating-Server: ws1-6.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1041461333-4971-2
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: 31 Dec 2002 16:59:36 +0000
To: Marijn Ros <marijn@mad.scientist.com>
Subject: Re: 2.4.21-pre2 IDE problems

> On Tue, 2002-12-31 at 12:18, Marijn Ros wrote:
> > However, when I try the new 2.4.21-pre2 taskfile IO setting, I get a
> > 'hda: lost interrupt' message every 30 seconds (the timeout period I
> > guess) during disk IO, making the machine unusable. I know this
> > setting is experimental, but I guess you would like to know about my
> > problems before the old code is phased out completely.
> 
> Taskfile I/O as opposed to ioctl is broken for PIO. I know about this
> and I've disabled it. I don't plan to fix that path for 2.4 but to keep
> the old read/write paths to reduce risk

Thanks. The attached patch tries to clarify the Configure.help based on this.

Bye,
 Marijn
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife


------------=_1041461333-4971-2
Content-Type: application/octet-stream; name="taskfile-io-doc.diff"
Content-Disposition: attachment; filename="taskfile-io-doc.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNC4yMS1wcmUyL0RvY3VtZW50YXRpb24vQ29uZmlndXJl
LmhlbHAJMjAwMi0xMi0yOSAxODo1Mzo1NC4wMDAwMDAwMDAgKzAxMDAKKysr
IENvbmZpZ3VyZS5oZWxwCTIwMDMtMDEtMDEgMjM6NDA6MjUuMDAwMDAwMDAw
ICswMTAwCkBAIC04MDgsMjEgKzgwOCwyNiBAQAogVXNlIFRhc2tmaWxlIEkv
TwogQ09ORklHX0lERV9UQVNLRklMRV9JTwogICBUaGlzIGlzIHRoZSAiSmV3
ZWwiIG9mIHRoZSBwYXRjaC4gIEl0IHdpbGwgZ28gYXdheSBhbmQgYmVjb21l
IHRoZSBuZXcKLSAgZHJpdmVyIGNvcmUuICBTaW5jZSBhbGwgdGhlIGNoaXBz
ZXRzL2hvc3Qgc2lkZSBoYXJkd2FyZSBkZWFsIHcvIHRoZWlyCi0gIGV4Y2Vw
dGlvbnMgaW4gInRoZWlyIGxvY2FsIGNvZGUiIGN1cnJlbnRseSwgYWRvcHRp
b24gb2YgYQotICBzdGFuZGFyZGl6ZWQgZGF0YS10cmFuc3BvcnQgaXMgdGhl
IG9ubHkgbG9naWNhbCBzb2x1dGlvbi4KKyAgZHJpdmVyIGNvcmUsIGJ1dCBw
cm9iYWJseSBub3QgaW4gdGhlIDIuNCB0aW1lZnJhbWUuICBTaW5jZSBhbGwg
dGhlCisgIGNoaXBzZXRzL2hvc3Qgc2lkZSBoYXJkd2FyZSBkZWFsIHcvIHRo
ZWlyIGV4Y2VwdGlvbnMgaW4gInRoZWlyIGxvY2FsCisgIGNvZGUiIGN1cnJl
bnRseSwgYWRvcHRpb24gb2YgYSBzdGFuZGFyZGl6ZWQgZGF0YS10cmFuc3Bv
cnQgaXMgdGhlIG9ubHkKKyAgbG9naWNhbCBzb2x1dGlvbi4KICAgQWRkaXRp
b25hbGx5IHdlIHBhY2tldGl6ZSB0aGUgcmVxdWVzdHMgYW5kIGdhaW4gcmFw
aWQgcGVyZm9ybWFuY2UgYW5kCiAgIGEgcmVkdWN0aW9uIGluIHN5c3RlbSBs
YXRlbmN5LiAgQWRkaXRpb25hbGx5IGJ5IHVzaW5nIGEgbWVtb3J5IHN0cnVj
dAogICBmb3IgdGhlIGNvbW1hbmRzIHdlIGNhbiByZWRpcmVjdCB0byBhIE1N
SU8gaG9zdCBoYXJkd2FyZSBpbiB0aGUgbmV4dAogICBnZW5lcmF0aW9uIG9m
IGNvbnRyb2xsZXJzLCBzcGVjaWZpY2FsbHkgc2Vjb25kIGdlbmVyYXRpb24g
VWx0cmExMzMKICAgYW5kIFNlcmlhbCBBVEEuCiAKKyAgVGhpcyBjb2RlIG9u
bHkgd29ya3MgZm9yIGNvbnRyb2xsZXJzIGluIERNQSBtb2RlIGF0IHRoZSBt
b21lbnQuICBJZiB5b3UKKyAgd2FudCBvciBoYXZlIHRvIHJ1biB5b3VyIGNv
bnRyb2xsZXIgaW4gUElPIG1vZGUsIGRvbid0IHVzZSB0aGlzIG9wdGlvbgor
ICBhcyBpdCB3aWxsIGZhaWwgaG9ycmlibHkuCisKICAgU2luY2UgdGhpcyBp
cyBhIG1ham9yIHRyYW5zaXRpb24sIGl0IHdhcyBkZWVtZWQgbmVjZXNzYXJ5
IHRvIG1ha2UgdGhlCiAgIGRyaXZlciBwYXRocyBidWlsZGFibGUgaW4gc2Vw
YXJhdGUgbW9kZWxzLiAgVGhlcmVmb3JlIGlmIHVzaW5nIHRoaXMKICAgb3B0
aW9uIGZhaWxzIGZvciB5b3VyIGFyY2ggdGhlbiB3ZSBuZWVkIHRvIGFkZHJl
c3MgdGhlIG5lZWRzIGZvciB0aGF0CiAgIGFyY2guCiAKLSAgSWYgeW91IHdh
bnQgdG8gdGVzdCB0aGlzIGZ1bmN0aW9uYWxpdHksIHNheSBZIGhlcmUuCisg
IElmIHlvdSB3YW50IHRvIHRlc3QgdGhpcyBmdW5jdGlvbmFsaXR5LCBzYXkg
WSBoZXJlLiAgT3RoZXJ3aXNlLCBzYXkgTi4KIAogRm9yY2UgRE1BCiBDT05G
SUdfQkxLX0RFVl9JREVETUFfRk9SQ0VECg==

------------=_1041461333-4971-2--
