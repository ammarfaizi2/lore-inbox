Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVD1JXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVD1JXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 05:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVD1JXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 05:23:20 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:8399 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261969AbVD1JV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 05:21:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=jVAYGsU62Rz6UFdsgOAL3lzKnRY737tUEubZNWzANKN8BSxtnHehBHFKIPYeSh217jT5i+8Q4x0Hbs7qmsKtYC24j/X0sUdHCqTEHH+0AgXpLWP4DSmsVApir6gkH/JEmuqZRTzmRGsXn1Ec7Vu7WrQBhcRi8fVp7g5KmzpM3gs=
Message-ID: <9cde8bff05042802213ec650e0@mail.gmail.com>
Date: Thu, 28 Apr 2005 18:21:52 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
In-Reply-To: <20050428083922.GA11542@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2609_17516049.1114680112235"
References: <9cde8bff050428005528ecf692@mail.gmail.com>
	 <20050428080914.GA10799@infradead.org>
	 <9cde8bff0504280138b979c08@mail.gmail.com>
	 <20050428083922.GA11542@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2609_17516049.1114680112235
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 4/28/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Apr 28, 2005 at 05:38:40PM +0900, aq wrote:
> > I dont see why we should keep a file in kernel tree without using it
> > (since the patch removes "source xfs/Kconfig). Anyway, here is another
> > patch that doesnt remove fs/xfs/Kconfig.
>=20
> No, you should not remove usage of it either.
>=20

OK, here is another patch. It is up to Andrew to pick the approriate.
But I still prefer the first patch, which provides both consistency in
interface and configuration.

What this patch does:

- Remove "menu" directive from fs/xfs/Kconfig, so XFS configuration is
done in the same screen as other filesystems.
- Move "config XFS_EXPORT " to the bottom, so the menu items aligns
better and consistent with others.
=20
# diffstat makefile.fs3.patch=20
 Kconfig |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

Signed-off-by: Nguyen Anh Quynh <aquynh@gmail.com>

------=_Part_2609_17516049.1114680112235
Content-Type: application/octet-stream; name="makefile.fs3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="makefile.fs3.patch"

ZGlmZiAtTnVycCAtWCBkb250ZGlmZi1hcSBhLzIuNi4xMi1yYzMvZnMveGZzL0tjb25maWcgYy8y
LjYuMTItcmMzL2ZzL3hmcy9LY29uZmlnCi0tLSBhLzIuNi4xMi1yYzMvZnMveGZzL0tjb25maWcJ
MjAwNS0wMy0wMiAxNjozODowOC4wMDAwMDAwMDAgKzA5MDAKKysrIGMvMi42LjEyLXJjMy9mcy94
ZnMvS2NvbmZpZwkyMDA1LTA0LTI4IDE3OjUxOjQ3LjAwMDAwMDAwMCArMDkwMApAQCAtMSw1ICsx
LDMgQEAKLW1lbnUgIlhGUyBzdXBwb3J0IgotCiBjb25maWcgWEZTX0ZTCiAJdHJpc3RhdGUgIlhG
UyBmaWxlc3lzdGVtIHN1cHBvcnQiCiAJc2VsZWN0IEVYUE9SVEZTIGlmIE5GU0QhPW4KQEAgLTIw
LDEwICsxOCw2IEBAIGNvbmZpZyBYRlNfRlMKIAkgIHN5c3RlbSBvZiB5b3VyIHJvb3QgcGFydGl0
aW9uIGlzIGNvbXBpbGVkIGFzIGEgbW9kdWxlLCB5b3UnbGwgbmVlZAogCSAgdG8gdXNlIGFuIGlu
aXRpYWwgcmFtZGlzayAoaW5pdHJkKSB0byBib290LgogCi1jb25maWcgWEZTX0VYUE9SVAotCWJv
b2wKLQlkZWZhdWx0IHkgaWYgWEZTX0ZTICYmIEVYUE9SVEZTCi0KIGNvbmZpZyBYRlNfUlQKIAli
b29sICJSZWFsdGltZSBzdXBwb3J0IChFWFBFUklNRU5UQUwpIgogCWRlcGVuZHMgb24gWEZTX0ZT
ICYmIEVYUEVSSU1FTlRBTApAQCAtODIsNCArNzYsNyBAQCBjb25maWcgWEZTX1BPU0lYX0FDTAog
CiAJICBJZiB5b3UgZG9uJ3Qga25vdyB3aGF0IEFjY2VzcyBDb250cm9sIExpc3RzIGFyZSwgc2F5
IE4uCiAKLWVuZG1lbnUKK2NvbmZpZyBYRlNfRVhQT1JUCisJYm9vbAorCWRlZmF1bHQgeSBpZiBY
RlNfRlMgJiYgRVhQT1JURlMKKwo=
------=_Part_2609_17516049.1114680112235--
