Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbUKTP4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbUKTP4g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 10:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKTP4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 10:56:36 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:42742 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262999AbUKTP4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 10:56:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=NfvE3E5NGQYt2J8V+vVTFrAsTZkrFaebmUnDqULB9tvfo9S2mbm9uE0yiFm/MKq6TqB9/GoYU0tphwxJ88MCbK9ckFf8Q9MaKlUN0irSsYsomLqk8H+yWJhOYTD9jTt3C02wJhLyUvhogm0t5TAMMwIRGMktXGZqLdZeenFVu/k=
Message-ID: <876ef97a04112007562d6797e@mail.gmail.com>
Date: Sat, 20 Nov 2004 10:56:32 -0500
From: Tobias DiPasquale <codeslinger@gmail.com>
Reply-To: Tobias DiPasquale <codeslinger@gmail.com>
To: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] add list_del_head function
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_911_27268275.1100966192953"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_911_27268275.1100966192953
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I was working with some queues the other day and I noticed that there
was a list_add_tail() function in list.h, but no list_del_head()
function. This struck me as a little odd, so I went ahead and
implemented one in order to complete full queue functionality. The
patch below was generated against pristine 2.6.9 kernel.org kernel
sources and is attached to this email.

Please CC me on any replies, as I'm not subscribed to LKML. Thanks :)

Name: Add list_del_head for full queue functionality
Status: Tested
Signed-off-by: Tobias DiPasquale <codeslinger@gmail.com>

-- 
[ Tobias DiPasquale ]
0x636f6465736c696e67657240676d61696c2e636f6d

------=_Part_911_27268275.1100966192953
Content-Type: application/octet-stream; name="list_del_head.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="list_del_head.patch"

ZGlmZiAtTnJ1cCBsaW51eC0yLjYuOS9pbmNsdWRlL2xpbnV4L2xpc3QuaCBsaW51eC9pbmNsdWRl
L2xpbnV4L2xpc3QuaAotLS0gbGludXgtMi42LjkvaW5jbHVkZS9saW51eC9saXN0LmgJMjAwNC0x
MC0xOCAyMTo1NDozMS4wMDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4L2luY2x1ZGUvbGludXgvbGlz
dC5oCTIwMDQtMTEtMjAgMTg6NTU6MTIuMzczNjU0MDQ4ICswMDAwCkBAIC0xNjYsNiArMTY2LDIx
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsaXN0X2RlbChzdHJ1Y3QgbGlzdF8KIH0KIAogLyoqCisg
KiBsaXN0X2RlbF9oZWFkIC0gZGVsZXRlcyBmaXJzdCBlbnRyeSBmcm9tIGxpc3QuCisgKiBAZW50
cnk6IHJldHVybiBwYXJhbWV0ZXI7IHdpbGwgY29udGFpbiBmb3JtZXIgaGVhZCBvZiBsaXN0IG9u
IHJldHVybi4KKyAqIEBoZWFkOiBoZWFkIG9mIGxpc3QgZnJvbSB3aGljaCB0byBkZWxldGUuCisg
KgorICogVGhpcyBmdW5jdGlvbiBpcyB1c2VmdWwgZm9yIGltcGxlbWVudGluZyBxdWV1ZXMuIENh
bGxlciBtdXN0IGVuc3VyZQorICogdGhlIGxpc3QgaXMgbm90IGVtcHR5IGJlZm9yZSBjYWxsaW5n
IHRoaXMgZnVuY3Rpb24uIE9uIHJldHVybiwgZW50cnkKKyAqIHdpbGwgcG9pbnQgdG8gdGhlIGZv
cm1lciBoZWFkIG9mIHRoZSBsaXN0LgorICovCitzdGF0aWMgaW5saW5lIHZvaWQgbGlzdF9kZWxf
aGVhZChzdHJ1Y3QgbGlzdF9oZWFkICoqZW50cnksIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCit7
CisJKmVudHJ5ID0gaGVhZC0+bmV4dDsKKwlsaXN0X2RlbChoZWFkLT5uZXh0KTsKK30KKworLyoq
CiAgKiBsaXN0X2RlbF9yY3UgLSBkZWxldGVzIGVudHJ5IGZyb20gbGlzdCB3aXRob3V0IHJlLWlu
aXRpYWxpemF0aW9uCiAgKiBAZW50cnk6IHRoZSBlbGVtZW50IHRvIGRlbGV0ZSBmcm9tIHRoZSBs
aXN0LgogICoK
------=_Part_911_27268275.1100966192953--
