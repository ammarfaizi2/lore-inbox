Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288842AbSAEPR5>; Sat, 5 Jan 2002 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288840AbSAEPRx>; Sat, 5 Jan 2002 10:17:53 -0500
Received: from ns.ithnet.com ([217.64.64.10]:5 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288843AbSAEPRj>;
	Sat, 5 Jan 2002 10:17:39 -0500
Date: Sat, 5 Jan 2002 16:17:27 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Phil Oester <kernel@theoesters.com>
Cc: nknight@pocketinet.com, linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Message-Id: <20020105161727.18f04fc3.skraw@ithnet.com>
In-Reply-To: <20020104172418.A28715@ns1.theoesters.com>
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp>
	<20020104220240.233ae66a.skraw@ithnet.com>
	<WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
	<20020104172418.A28715@ns1.theoesters.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__5_Jan_2002_16:17:27_+0100_08304990"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__5_Jan_2002_16:17:27_+0100_08304990
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jan 2002 17:24:18 -0800
Phil Oester <kernel@theoesters.com> wrote:

> On Fri, Jan 04, 2002 at 04:42:43PM -0800, Nicholas Knight wrote:
> > The one catch is that -j is specified without a number.
> 
> [snip superfluous description of what 'make -j' implies]
> 
> > number, your system is dead. A user issue because it seems the user is 
> > using the option without fully comprehending the consequences.
> 
> eh?  Trust me - i understand the implications of make -j.  It's not an
unreasonable test, especially on a machine with 1gb ram/swap.  For reference,
read Rik's email regarding his reverse VM patch:> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101007711817127&w=2
> 
> Might be enlightening

I guess this testcase is somewhat driving in the direction of Martins test with
some setis running, meaning it has a lot of standard processes that need files
and try to work out something. Can you try Martins patch at your side, redo the
-j story and give us a result? I attached it for an easy go :-)

Thanks,
Stephan


--Multipart_Sat__5_Jan_2002_16:17:27_+0100_08304990
Content-Type: text/plain;
 name="vmscan.patch.2.4.17.c"
Content-Disposition: attachment;
 filename="vmscan.patch.2.4.17.c"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LnZpcmdpbi9tbS92bXNjYW4uYwlNb24gRGVjIDMxIDEyOjQ2OjI1IDIwMDEKKysr
IGxpbnV4L21tL3Ztc2Nhbi5jCVRodSBKYW4gIDMgMTk6NDM6MDIgMjAwMgpAQCAtMzk0LDkgKzM5
NCw5IEBACiAJCWlmIChQYWdlRGlydHkocGFnZSkgJiYgaXNfcGFnZV9jYWNoZV9mcmVlYWJsZShw
YWdlKSAmJiBwYWdlLT5tYXBwaW5nKSB7CiAJCQkvKgogCQkJICogSXQgaXMgbm90IGNyaXRpY2Fs
IGhlcmUgdG8gd3JpdGUgaXQgb25seSBpZgotCQkJICogdGhlIHBhZ2UgaXMgdW5tYXBwZWQgYmVh
dXNlIGFueSBkaXJlY3Qgd3JpdGVyCisJCQkgKiB0aGUgcGFnZSBpcyB1bm1hcHBlZCBiZWNhdXNl
IGFueSBkaXJlY3Qgd3JpdGVyCiAJCQkgKiBsaWtlIE9fRElSRUNUIHdvdWxkIHNldCB0aGUgUEdf
ZGlydHkgYml0ZmxhZwotCQkJICogb24gdGhlIHBoaXNpY2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1
Y2Nlc3NmdWxseQorCQkJICogb24gdGhlIHBoeXNpY2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nl
c3NmdWxseQogCQkJICogcGlubmVkIGl0IGFuZCBhZnRlciB0aGUgSS9PIHRvIHRoZSBwYWdlIGlz
IGZpbmlzaGVkLAogCQkJICogc28gdGhlIGRpcmVjdCB3cml0ZXMgdG8gdGhlIHBhZ2UgY2Fubm90
IGdldCBsb3N0LgogCQkJICovCkBAIC00ODAsMTEgKzQ4MCwxNCBAQAogCiAJCQkvKgogCQkJICog
QWxlcnQhIFdlJ3ZlIGZvdW5kIHRvbyBtYW55IG1hcHBlZCBwYWdlcyBvbiB0aGUKLQkJCSAqIGlu
YWN0aXZlIGxpc3QsIHNvIHdlIHN0YXJ0IHN3YXBwaW5nIG91dCBub3chCisJCQkgKiBpbmFjdGl2
ZSBsaXN0LgorCQkJICogTW92ZSByZWZlcmVuY2VkIHBhZ2VzIHRvIHRoZSBhY3RpdmUgbGlzdC4K
IAkJCSAqLwotCQkJc3Bpbl91bmxvY2soJnBhZ2VtYXBfbHJ1X2xvY2spOwotCQkJc3dhcF9vdXQo
cHJpb3JpdHksIGdmcF9tYXNrLCBjbGFzc3pvbmUpOwotCQkJcmV0dXJuIG5yX3BhZ2VzOworCQkJ
aWYgKFBhZ2VSZWZlcmVuY2VkKHBhZ2UpKSB7CisJCQkJZGVsX3BhZ2VfZnJvbV9pbmFjdGl2ZV9s
aXN0KHBhZ2UpOworCQkJCWFkZF9wYWdlX3RvX2FjdGl2ZV9saXN0KHBhZ2UpOworCQkJfQorCQkJ
Y29udGludWU7CiAJCX0KIAogCQkvKgpAQCAtNTIxLDYgKzUyNCw5IEBACiAJfQogCXNwaW5fdW5s
b2NrKCZwYWdlbWFwX2xydV9sb2NrKTsKIAorCWlmIChtYXhfbWFwcGVkIDw9IDAgJiYgbnJfcGFn
ZXMgPiAwKQorCQlzd2FwX291dChwcmlvcml0eSwgZ2ZwX21hc2ssIGNsYXNzem9uZSk7CisKIAly
ZXR1cm4gbnJfcGFnZXM7CiB9CiAK

--Multipart_Sat__5_Jan_2002_16:17:27_+0100_08304990--
