Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVD1IuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVD1IuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVD1Ilw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:41:52 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:44116 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261961AbVD1Iil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:38:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=hm/v5z426IOP0Z9no6tbsnvIch5hVBCFbWxIQOb+/qhHgvz0ktJI9ffcdIJUKhMhJ0zGq2FHa0wzk4pt9O6yx0vdQVx7P8gTdWogHWQF2RnK70FGuIPaalsNbXME8HcDv/7vKDRTmI4eo23dZkID7Itirw0ODtBAMNfgX57hWGI=
Message-ID: <9cde8bff0504280138b979c08@mail.gmail.com>
Date: Thu, 28 Apr 2005 17:38:40 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
In-Reply-To: <20050428080914.GA10799@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2533_33024791.1114677520675"
References: <9cde8bff050428005528ecf692@mail.gmail.com>
	 <20050428080914.GA10799@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2533_33024791.1114677520675
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 4/28/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Apr 28, 2005 at 04:55:48PM +0900, aq wrote:
> > hello,
> >
> > At the moment, the configuration interface of Filesystem is not very co=
nsistent:
> >
> > - All other filesystem configurations (like Reiserfs, JFS, ext3,...)
> > is in fs/Kconfig, but only XFS is in a separate file fs/xfs/Kconfig
> > - All other filesystem configuration is processed in the same screen
> > (using a kind of drop-down interface), but XFS configuration is done
> > in a separate screen.
> >
> > Here is the patch to fix the problem: it moves XFS configuration from
> > fs/xfs/Kconfig to fs/Kconfig, makes it to do all the configuration in
> > the same screen (by removing "menu" directive), and removes the
> > unnecessary fs/xfs/Kconfig.
>=20
> The screen bits is fine, btu please keep fs/xfs/Kconfig.  It make maintai=
nce
> a lot a easier for us XFS people.
>=20
>=20

I dont see why we should keep a file in kernel tree without using it
(since the patch removes "source xfs/Kconfig). Anyway, here is another
patch that doesnt remove fs/xfs/Kconfig.

Also note that this patch (and the last one, too) moves "config
XFS_EXPOR" to the bottom, so the menu intems aligns better and
consistently with others (like what Reiserfs, JFS,... are doing)

Andrew, please pick one of these two. Thank you.

# diffstat makefile.fs2.patch=20
 Kconfig |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
 1 files changed, 81 insertions(+), 1 deletion(-)

Signed-off-by: Nguyen Anh Quynh <aquynh@gmail.com>\

------=_Part_2533_33024791.1114677520675
Content-Type: application/octet-stream; name="makefile.fs2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="makefile.fs2.patch"

ZGlmZiAtTnVycCAtWCBkb250ZGlmZi1hcSBhLzIuNi4xMi1yYzMvZnMvS2NvbmZpZyBiLzIuNi4x
Mi1yYzMvZnMvS2NvbmZpZwotLS0gYS8yLjYuMTItcmMzL2ZzL0tjb25maWcJMjAwNS0wNC0yOCAw
MDoyNTo1NC4wMDAwMDAwMDAgKzA5MDAKKysrIGIvMi42LjEyLXJjMy9mcy9LY29uZmlnCTIwMDUt
MDQtMjggMDA6MTc6NTkuMDAwMDAwMDAwICswOTAwCkBAIC0zMDQsNyArMzA0LDg3IEBAIGNvbmZp
ZyBGU19QT1NJWF9BQ0wKIAlkZXBlbmRzIG9uIEVYVDJfRlNfUE9TSVhfQUNMIHx8IEVYVDNfRlNf
UE9TSVhfQUNMIHx8IEpGU19QT1NJWF9BQ0wgfHwgUkVJU0VSRlNfRlNfUE9TSVhfQUNMIHx8IE5G
U0RfVjQKIAlkZWZhdWx0IHkKIAotc291cmNlICJmcy94ZnMvS2NvbmZpZyIKK2NvbmZpZyBYRlNf
RlMKKwl0cmlzdGF0ZSAiWEZTIGZpbGVzeXN0ZW0gc3VwcG9ydCIKKwlzZWxlY3QgRVhQT1JURlMg
aWYgTkZTRCE9bgorCWhlbHAKKwkgIFhGUyBpcyBhIGhpZ2ggcGVyZm9ybWFuY2Ugam91cm5hbGlu
ZyBmaWxlc3lzdGVtIHdoaWNoIG9yaWdpbmF0ZWQKKwkgIG9uIHRoZSBTR0kgSVJJWCBwbGF0Zm9y
bS4gIEl0IGlzIGNvbXBsZXRlbHkgbXVsdGktdGhyZWFkZWQsIGNhbgorCSAgc3VwcG9ydCBsYXJn
ZSBmaWxlcyBhbmQgbGFyZ2UgZmlsZXN5c3RlbXMsIGV4dGVuZGVkIGF0dHJpYnV0ZXMsCisJICB2
YXJpYWJsZSBibG9jayBzaXplcywgaXMgZXh0ZW50IGJhc2VkLCBhbmQgbWFrZXMgZXh0ZW5zaXZl
IHVzZSBvZgorCSAgQnRyZWVzIChkaXJlY3RvcmllcywgZXh0ZW50cywgZnJlZSBzcGFjZSkgdG8g
YWlkIGJvdGggcGVyZm9ybWFuY2UKKwkgIGFuZCBzY2FsYWJpbGl0eS4KKworCSAgUmVmZXIgdG8g
dGhlIGRvY3VtZW50YXRpb24gYXQgPGh0dHA6Ly9vc3Muc2dpLmNvbS9wcm9qZWN0cy94ZnMvPgor
CSAgZm9yIGNvbXBsZXRlIGRldGFpbHMuICBUaGlzIGltcGxlbWVudGF0aW9uIGlzIG9uLWRpc2sg
Y29tcGF0aWJsZQorCSAgd2l0aCB0aGUgSVJJWCB2ZXJzaW9uIG9mIFhGUy4KKworCSAgVG8gY29t
cGlsZSB0aGlzIGZpbGUgc3lzdGVtIHN1cHBvcnQgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6
IHRoZQorCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIHhmcy4gIEJlIGF3YXJlLCBob3dldmVyLCB0
aGF0IGlmIHRoZSBmaWxlCisJICBzeXN0ZW0gb2YgeW91ciByb290IHBhcnRpdGlvbiBpcyBjb21w
aWxlZCBhcyBhIG1vZHVsZSwgeW91J2xsIG5lZWQKKwkgIHRvIHVzZSBhbiBpbml0aWFsIHJhbWRp
c2sgKGluaXRyZCkgdG8gYm9vdC4KKworY29uZmlnIFhGU19SVAorCWJvb2wgIlJlYWx0aW1lIHN1
cHBvcnQgKEVYUEVSSU1FTlRBTCkiCisJZGVwZW5kcyBvbiBYRlNfRlMgJiYgRVhQRVJJTUVOVEFM
CisJaGVscAorCSAgSWYgeW91IHNheSBZIGhlcmUgeW91IHdpbGwgYmUgYWJsZSB0byBtb3VudCBh
bmQgdXNlIFhGUyBmaWxlc3lzdGVtcworCSAgd2hpY2ggY29udGFpbiBhIHJlYWx0aW1lIHN1YnZv
bHVtZS4gVGhlIHJlYWx0aW1lIHN1YnZvbHVtZSBpcyBhCisJICBzZXBhcmF0ZSBhcmVhIG9mIGRp
c2sgc3BhY2Ugd2hlcmUgb25seSBmaWxlIGRhdGEgaXMgc3RvcmVkLiBUaGUKKwkgIHJlYWx0aW1l
IHN1YnZvbHVtZSBpcyBkZXNpZ25lZCB0byBwcm92aWRlIHZlcnkgZGV0ZXJtaW5pc3RpYworCSAg
ZGF0YSByYXRlcyBzdWl0YWJsZSBmb3IgbWVkaWEgc3RyZWFtaW5nIGFwcGxpY2F0aW9ucy4KKwor
CSAgU2VlIHRoZSB4ZnMgbWFuIHBhZ2UgaW4gc2VjdGlvbiA1IGZvciBhIGJpdCBtb3JlIGluZm9y
bWF0aW9uLgorCisJICBUaGlzIGZlYXR1cmUgaXMgdW5zdXBwb3J0ZWQgYXQgdGhpcyB0aW1lLCBp
cyBub3QgeWV0IGZ1bGx5CisJICBmdW5jdGlvbmFsLCBhbmQgbWF5IGNhdXNlIHNlcmlvdXMgcHJv
YmxlbXMuCisKKwkgIElmIHVuc3VyZSwgc2F5IE4uCisKK2NvbmZpZyBYRlNfUVVPVEEKKwlib29s
ICJRdW90YSBzdXBwb3J0IgorCWRlcGVuZHMgb24gWEZTX0ZTCisJaGVscAorCSAgSWYgeW91IHNh
eSBZIGhlcmUsIHlvdSB3aWxsIGJlIGFibGUgdG8gc2V0IGxpbWl0cyBmb3IgZGlzayB1c2FnZSBv
bgorCSAgYSBwZXIgdXNlciBhbmQvb3IgYSBwZXIgZ3JvdXAgYmFzaXMgdW5kZXIgWEZTLiAgWEZT
IGNvbnNpZGVycyBxdW90YQorCSAgaW5mb3JtYXRpb24gYXMgZmlsZXN5c3RlbSBtZXRhZGF0YSBh
bmQgdXNlcyBqb3VybmFsaW5nIHRvIHByb3ZpZGUgYQorCSAgaGlnaGVyIGxldmVsIGd1YXJhbnRl
ZSBvZiBjb25zaXN0ZW5jeS4gIFRoZSBvbi1kaXNrIGRhdGEgZm9ybWF0IGZvcgorCSAgcXVvdGEg
aXMgYWxzbyBjb21wYXRpYmxlIHdpdGggdGhlIElSSVggdmVyc2lvbiBvZiBYRlMsIGFsbG93aW5n
IGEKKwkgIGZpbGVzeXN0ZW0gdG8gYmUgbWlncmF0ZWQgYmV0d2VlbiBMaW51eCBhbmQgSVJJWCB3
aXRob3V0IGFueSBuZWVkCisJICBmb3IgY29udmVyc2lvbi4KKworCSAgSWYgdW5zdXJlLCBzYXkg
Ti4gIE1vcmUgY29tcHJlaGVuc2l2ZSBkb2N1bWVudGF0aW9uIGNhbiBiZSBmb3VuZCBpbgorCSAg
UkVBRE1FLnF1b3RhIGluIHRoZSB4ZnNwcm9ncyBwYWNrYWdlLiAgWEZTIHF1b3RhIGNhbiBiZSB1
c2VkIGVpdGhlcgorCSAgd2l0aCBvciB3aXRob3V0IHRoZSBnZW5lcmljIHF1b3RhIHN1cHBvcnQg
ZW5hYmxlZCAoQ09ORklHX1FVT1RBKSAtCisJICB0aGV5IGFyZSBjb21wbGV0ZWx5IGluZGVwZW5k
ZW50IHN1YnN5c3RlbXMuCisKK2NvbmZpZyBYRlNfU0VDVVJJVFkKKwlib29sICJTZWN1cml0eSBM
YWJlbCBzdXBwb3J0IgorCWRlcGVuZHMgb24gWEZTX0ZTCisJaGVscAorCSAgU2VjdXJpdHkgbGFi
ZWxzIHN1cHBvcnQgYWx0ZXJuYXRpdmUgYWNjZXNzIGNvbnRyb2wgbW9kZWxzCisJICBpbXBsZW1l
bnRlZCBieSBzZWN1cml0eSBtb2R1bGVzIGxpa2UgU0VMaW51eC4gIFRoaXMgb3B0aW9uCisJICBl
bmFibGVzIGFuIGV4dGVuZGVkIGF0dHJpYnV0ZSBuYW1lc3BhY2UgZm9yIGlub2RlIHNlY3VyaXR5
CisJICBsYWJlbHMgaW4gdGhlIFhGUyBmaWxlc3lzdGVtLgorCisJICBJZiB5b3UgYXJlIG5vdCB1
c2luZyBhIHNlY3VyaXR5IG1vZHVsZSB0aGF0IHJlcXVpcmVzIHVzaW5nCisJICBleHRlbmRlZCBh
dHRyaWJ1dGVzIGZvciBpbm9kZSBzZWN1cml0eSBsYWJlbHMsIHNheSBOLgorCitjb25maWcgWEZT
X1BPU0lYX0FDTAorCWJvb2wgIlBPU0lYIEFDTCBzdXBwb3J0IgorCWRlcGVuZHMgb24gWEZTX0ZT
CisJaGVscAorCSAgUE9TSVggQWNjZXNzIENvbnRyb2wgTGlzdHMgKEFDTHMpIHN1cHBvcnQgcGVy
bWlzc2lvbnMgZm9yIHVzZXJzIGFuZAorCSAgZ3JvdXBzIGJleW9uZCB0aGUgb3duZXIvZ3JvdXAv
d29ybGQgc2NoZW1lLgorCisJICBUbyBsZWFybiBtb3JlIGFib3V0IEFjY2VzcyBDb250cm9sIExp
c3RzLCB2aXNpdCB0aGUgUE9TSVggQUNMcyBmb3IKKwkgIExpbnV4IHdlYnNpdGUgPGh0dHA6Ly9h
Y2wuYmVzdGJpdHMuYXQvPi4KKworCSAgSWYgeW91IGRvbid0IGtub3cgd2hhdCBBY2Nlc3MgQ29u
dHJvbCBMaXN0cyBhcmUsIHNheSBOLgorCitjb25maWcgWEZTX0VYUE9SVAorCWJvb2wKKwlkZWZh
dWx0IHkgaWYgWEZTX0ZTICYmIEVYUE9SVEZTCiAKIGNvbmZpZyBNSU5JWF9GUwogCXRyaXN0YXRl
ICJNaW5peCBmcyBzdXBwb3J0Igo=
------=_Part_2533_33024791.1114677520675--
