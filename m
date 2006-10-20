Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWJUAxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWJUAxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJUAxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:53:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:6994 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030366AbWJUAxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:53:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=iXXmhG/GvHufj0MougMu09skF/S7l6o62mN2t1ZbcO+ODcrpKQT93zgXQZER39k7EajbZG4zdwaW+YKHHR0zPp1186PnM4v+Oa46LR7RuxVY/CrNJK9RqWvlELKfVXCP/aGO2gMJDNPM90Yfa/vgWA9s7ShIKW+DQKevizu2oPI=
Message-ID: <55c223960610201033j70fb8d68p1f737d4de0720a9b@mail.gmail.com>
Date: Fri, 20 Oct 2006 18:33:10 +0100
From: "Alex Owen" <r.alex.owen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
In-Reply-To: <1159983049.25772.84.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25559_22942705.1161365590092"
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
	 <1159983049.25772.84.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_25559_22942705.1161365590092
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a patch against the RHEL4_U3 forcedeth.c source as distributed
by nvidia in the package
http://download.nvidia.com/XFree86/nforce/1.11/NFORCE-Linux-x86-1.11.zip

It performs the test suggested by Alan Cox and reveses the MAC address
as needed.
It is not pretty but is solves my issue while I am waiting for my PC
vendor to get a new BIOS sorted with the upgraded bootagent that fixes
the problem.
As it may help others I'm posting it here!!!

Alex Owen

On 04/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Mer, 2006-10-04 am 17:19 +0100, ysgrifennodd Alex Owen:
> > The obvious fix for this is to try and read the MAC address from the
> > canonical location... ie where is the source of the address writen
> > into the controlers registers at power on? But do we know where that
> > may be?
>
> Why not check if the first or last 3 bytes are the Nvidia owner bits.
> The only card that will misdetect is
>
> 00:16:17:17:16:00
>
> which doesn't matter anyway
>
> Alan
>
>

------=_Part_25559_22942705.1161365590092
Content-Type: text/x-patch; name=forcedeth-pxe-reversed-mac.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etiuuf8a
Content-Disposition: attachment; filename="forcedeth-pxe-reversed-mac.patch"

LS0tIGZvcmNlZGV0aC5jLm9yaWcJMjAwNi0wNi0xOSAxMzoxMDozMi4wMDAwMDAwMDAgKzAxMDAK
KysrIGZvcmNlZGV0aC5jCTIwMDYtMTAtMjAgMTc6NTI6MzMuMDAwMDAwMDAwICswMTAwCkBAIC00
Nzg0LDEyICs0Nzg0LDM5IEBACiAJbnAtPm9yaWdfbWFjWzBdID0gcmVhZGwoYmFzZSArIE52UmVn
TWFjQWRkckEpOwogCW5wLT5vcmlnX21hY1sxXSA9IHJlYWRsKGJhc2UgKyBOdlJlZ01hY0FkZHJC
KTsKIAorLyogUkFPIEZJWE1FIC0gaWYgbWFjIGFkZHJlc3MgaXMgcmV2ZXJzZWQgKHRlc3Qgb2lk
KSB0aGVuIGZsaXAgaW50byBkZXZfYWRkciB0aGVuIHN0cmFpdCBjb3B5IHRvIG9yaWcgbWFjLi4u
IFRIRU4gY29udGludWUgKi8KKworICAgICAgICBpZiAoICggKG5wLT5vcmlnX21hY1swXSA+PiAx
NikgJiAweGZmICkgPT0gMHgxNyAmJgorICAgICAgICAgICAgICggKG5wLT5vcmlnX21hY1swXSA+
PiAgOCkgJiAweGZmICkgPT0gMHgxNiAmJgorICAgICAgICAgICAgICggKG5wLT5vcmlnX21hY1sw
XSA+PiAgMCkgJiAweGZmICkgPT0gMHgwMCApCisgICAgICAgICAgICAgICAgeyAvKiBtYWMgYWRk
cmVzcyBpcyByZXZlcmVzZWQgKFBYRSBidWcpIHNvIGNvcHkgaW50byBkZXZfYWRkciAqLworICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2LT5kZXZfYWRkclswXSA9IChucC0+b3JpZ19tYWNbMV0g
Pj4gIDgpICYgMHhmZjsKKyAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+ZGV2X2FkZHJbMV0g
PSAobnAtPm9yaWdfbWFjWzFdID4+ICAwKSAmIDB4ZmY7CisgICAgICAgICAgICAgICAgICAgICAg
ICBkZXYtPmRldl9hZGRyWzJdID0gKG5wLT5vcmlnX21hY1swXSA+PiAyNCkgJiAweGZmOworICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2LT5kZXZfYWRkclszXSA9IChucC0+b3JpZ19tYWNbMF0g
Pj4gMTYpICYgMHhmZjsKKyAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+ZGV2X2FkZHJbNF0g
PSAobnAtPm9yaWdfbWFjWzBdID4+ICA4KSAmIDB4ZmY7CisgICAgICAgICAgICAgICAgICAgICAg
ICBkZXYtPmRldl9hZGRyWzVdID0gKG5wLT5vcmlnX21hY1swXSA+PiAgMCkgJiAweGZmOworICAg
ICAgICAgICAgICAgICAgLyogTm93IGNvcHkgInJldmVyZXNlZCIgaW50byBvcmlnX21hYyAqLwor
ICAgICAgICAgICAgICAgICAgICAgICAgbnAtPm9yaWdfbWFjWzBdID0gKGRldi0+ZGV2X2FkZHJb
MF0gPDwgMCkgKyAoZGV2LT5kZXZfYWRkclsxXSA8PCA4KSArCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoZGV2LT5kZXZfYWRkclsyXSA8PCAxNikgKyAoZGV2LT5k
ZXZfYWRkclszXSA8PCAyNCk7CisgICAgICAgICAgICAgICAgICAgICAgICBucC0+b3JpZ19tYWNb
MV0gPSAoZGV2LT5kZXZfYWRkcls0XSA8PCAwKSArIChkZXYtPmRldl9hZGRyWzVdIDw8IDgpOwor
CisgICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgImZvcmNlZGV0aDogUkVW
RVJTRUQgTWFjIGFkZHJlc3MgZGV0ZWN0ZWQ6ICUwMng6JTAyeDolMDJ4OiUwMng6JTAyeDolMDJ4
XG4iLAorICAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5kZXZfYWRkclswXSwgZGV2LT5kZXZf
YWRkclsxXSwgZGV2LT5kZXZfYWRkclsyXSwKKyAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+
ZGV2X2FkZHJbM10sIGRldi0+ZGV2X2FkZHJbNF0sIGRldi0+ZGV2X2FkZHJbNV0pOworCSAgICAg
ICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgIkZpeGluZyBNQUMgYWRkcmVzcy5cbiIpOworICAg
ICAgICAgICAgICAgIH0KKwogCWRldi0+ZGV2X2FkZHJbMF0gPSAobnAtPm9yaWdfbWFjWzFdID4+
ICA4KSAmIDB4ZmY7CiAJZGV2LT5kZXZfYWRkclsxXSA9IChucC0+b3JpZ19tYWNbMV0gPj4gIDAp
ICYgMHhmZjsKIAlkZXYtPmRldl9hZGRyWzJdID0gKG5wLT5vcmlnX21hY1swXSA+PiAyNCkgJiAw
eGZmOwogCWRldi0+ZGV2X2FkZHJbM10gPSAobnAtPm9yaWdfbWFjWzBdID4+IDE2KSAmIDB4ZmY7
CiAJZGV2LT5kZXZfYWRkcls0XSA9IChucC0+b3JpZ19tYWNbMF0gPj4gIDgpICYgMHhmZjsKIAlk
ZXYtPmRldl9hZGRyWzVdID0gKG5wLT5vcmlnX21hY1swXSA+PiAgMCkgJiAweGZmOworICAgICAg
IAlwcmludGsoS0VSTl9FUlIgImZvcmNlZGV0aDogdXNpbmcgTWFjIGFkZHJlc3M6ICUwMng6JTAy
eDolMDJ4OiUwMng6JTAyeDolMDJ4XG4iLAorCQkJZGV2LT5kZXZfYWRkclswXSwgZGV2LT5kZXZf
YWRkclsxXSwgZGV2LT5kZXZfYWRkclsyXSwKKwkJCWRldi0+ZGV2X2FkZHJbM10sIGRldi0+ZGV2
X2FkZHJbNF0sIGRldi0+ZGV2X2FkZHJbNV0pOworCiAjaWYgTElOVVhfVkVSU0lPTl9DT0RFID4g
S0VSTkVMX1ZFUlNJT04oMiw2LDEzKQogCW1lbWNweShkZXYtPnBlcm1fYWRkciwgZGV2LT5kZXZf
YWRkciwgZGV2LT5hZGRyX2xlbik7CiAK
------=_Part_25559_22942705.1161365590092--
