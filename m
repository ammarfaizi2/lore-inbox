Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319414AbSIFWdk>; Fri, 6 Sep 2002 18:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319416AbSIFWdk>; Fri, 6 Sep 2002 18:33:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:53157 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319414AbSIFWdi>;
	Fri, 6 Sep 2002 18:33:38 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, hch@infradead.org,
       neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF1F5F01D1.E414689E-ON87256C2C.007B2D30@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Fri, 6 Sep 2002 16:36:39 -0600
Subject: Re: NFS lockd patch proposal for user-level control of the grace period 
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Build V60_M14_08012002 Release
 Candidate|August 01, 2002) at 09/06/2002 16:36:41
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=08BBE6BFDFE8ABA08f9e8a93df938690918c08BBE6BFDFE8ABA0"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=08BBE6BFDFE8ABA08f9e8a93df938690918c08BBE6BFDFE8ABA0
Content-type: text/plain; charset=US-ASCII





Christoph, Alan, Neil,

Attached you will find the patch with the sysctl implementation of my
previous patch to enable grace period control from user-land.
Please let me know if this looks good enough for inclusion in the kernel
distribution or whether I still need to do something else.
Note this piece is derived from net/sunrpc/sysctl.c, which by the way I
think has a problem with the READ/WRITE verifys which seem
 to be swicthed which I fixed in lockd version but not there, you may want
to take a look at net/sunrpc/sysctl.c and fix that although that's a minor
thing.

(See attached file: lockd-sysctl.patch)


Regards, Juan



|---------+---------------------------->
|         |           Alan Cox         |
|         |           <alan@lxorguk.   |
|         |           ukuu.org.uk>     |
|         |                            |
|         |           09/05/02 11:37 AM|
|         |                            |
|---------+---------------------------->
  >-----------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                             |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                                |
  |       cc:                                                                                                                   |
  |       Subject:  Re: NFS lockd patch proposal for user-level control of the grace  period                                    |
  |                                                                                                                             |
  |                                                                                                                             |
  >-----------------------------------------------------------------------------------------------------------------------------|



I was waiting for a version that used the sysctl /proc/sys interface
instead. The concept of the interface is clearly fine



--0__=08BBE6BFDFE8ABA08f9e8a93df938690918c08BBE6BFDFE8ABA0
Content-type: application/octet-stream; 
	name="lockd-sysctl.patch"
Content-Disposition: attachment; filename="lockd-sysctl.patch"
Content-transfer-encoding: base64

ZGlmZiAtcmNOIGxpbnV4LTIuNC4xOS9mcy9sb2NrZC9NYWtlZmlsZSBsaW51eC0yLjQuMTktbG9j
a2Qtc3lzY3RsL2ZzL2xvY2tkL01ha2VmaWxlCioqKiBsaW51eC0yLjQuMTkvZnMvbG9ja2QvTWFr
ZWZpbGUJRnJpIERlYyAyOSAxNDowNzoyMyAyMDAwCi0tLSBsaW51eC0yLjQuMTktbG9ja2Qtc3lz
Y3RsL2ZzL2xvY2tkL01ha2VmaWxlCUZyaSBTZXAgIDYgMTk6MDk6MDIgMjAwMgoqKioqKioqKioq
KioqKioKKioqIDEyLDE4ICoqKioKICBleHBvcnQtb2JqcyA6PSBsb2NrZF9zeW1zLm8KICAKICBv
YmoteSAgICA6PSBjbG50bG9jay5vIGNsbnRwcm9jLm8gaG9zdC5vIHN2Yy5vIHN2Y2xvY2subyBz
dmNzaGFyZS5vIFwKISAJICAgIHN2Y3Byb2MubyBzdmNzdWJzLm8gbW9uLm8geGRyLm8gbG9ja2Rf
c3ltcy5vCiAgCiAgb2JqLSQoQ09ORklHX0xPQ0tEX1Y0KSArPSB4ZHI0Lm8gc3ZjNHByb2Mubwog
IAotLS0gMTIsMTggLS0tLQogIGV4cG9ydC1vYmpzIDo9IGxvY2tkX3N5bXMubwogIAogIG9iai15
ICAgIDo9IGNsbnRsb2NrLm8gY2xudHByb2MubyBob3N0Lm8gc3ZjLm8gc3ZjbG9jay5vIHN2Y3No
YXJlLm8gXAohIAkgICAgc3ZjcHJvYy5vIHN2Y3N1YnMubyBtb24ubyB4ZHIubyBsb2NrZF9zeW1z
Lm8gc3lzY3RsLm8KICAKICBvYmotJChDT05GSUdfTE9DS0RfVjQpICs9IHhkcjQubyBzdmM0cHJv
Yy5vCiAgCmRpZmYgLXJjTiBsaW51eC0yLjQuMTkvZnMvbG9ja2Qvc3ZjLmMgbGludXgtMi40LjE5
LWxvY2tkLXN5c2N0bC9mcy9sb2NrZC9zdmMuYwoqKiogbGludXgtMi40LjE5L2ZzL2xvY2tkL3N2
Yy5jCVN1biBPY3QgMjEgMTA6MzI6MzMgMjAwMQotLS0gbGludXgtMi40LjE5LWxvY2tkLXN5c2N0
bC9mcy9sb2NrZC9zdmMuYwlGcmkgU2VwICA2IDIxOjQ0OjMyIDIwMDIKKioqKioqKioqKioqKioq
CioqKiA1OCw2MyAqKioqCi0tLSA1OCw2OSAtLS0tCiAgdW5zaWduZWQgbG9uZwkJCW5sbV90aW1l
b3V0ID0gTE9DS0RfREZMVF9USU1FTzsKICB1bnNpZ25lZCBsb25nCQkJbmxtX3VkcHBvcnQsIG5s
bV90Y3Bwb3J0OwogIAorIC8qIEltcG9ydHMgbmVlZGVkIHRvIHN1cHBvcnQgc3lzY3RsICovCisg
ZXh0ZXJuIHZvaWQgICAgICAgICAgICAgbG9ja2RfcmVnaXN0ZXJfc3lzY3RsKHZvaWQpOworIGV4
dGVybiB2b2lkICAgICAgICAgICAgIGxvY2tkX2RlcmVnaXN0ZXJfc3lzY3RsKHZvaWQpOworIAor
IHN0YXRpYyB1bnNpZ25lZCBsb25nICAgICAgICAgICAgZ3JhY2VfcGVyaW9kX2V4cGlyZTsKKyAK
ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBzZXRfZ3JhY2VfcGVyaW9kKHZvaWQpCiAgewogIAl1bnNp
Z25lZCBsb25nIGdyYWNlX3BlcmlvZDsKKioqKioqKioqKioqKioqCioqKiA3Miw4MiAqKioqCiAg
CXJldHVybiBncmFjZV9wZXJpb2QgKyBqaWZmaWVzOwogIH0KICAKISBzdGF0aWMgaW5saW5lIHZv
aWQgY2xlYXJfZ3JhY2VfcGVyaW9kKHZvaWQpCiAgewogIAlubG1zdmNfZ3JhY2VfcGVyaW9kID0g
MDsKICB9CiAgCiAgLyoKICAgKiBUaGlzIGlzIHRoZSBsb2NrZCBrZXJuZWwgdGhyZWFkCiAgICov
Ci0tLSA3OCw5NyAtLS0tCiAgCXJldHVybiBncmFjZV9wZXJpb2QgKyBqaWZmaWVzOwogIH0KICAK
ISAvKiBQdWJsaWMgdmVyc2lvbiBvZiBzZXRfZ3JhY2VfcGVyaW9kIHVzZWQgZnJvbSBzeXNjdGwu
YyAqLwohIGlubGluZSB2b2lkIHN0YXJ0X2dyYWNlX3BlcmlvZCh2b2lkKQohIHsKISAKISAJZ3Jh
Y2VfcGVyaW9kX2V4cGlyZSA9IHNldF9ncmFjZV9wZXJpb2QoKTsKISAKISB9CiEgCiEgaW5saW5l
IHZvaWQgY2xlYXJfZ3JhY2VfcGVyaW9kKHZvaWQpCiAgewogIAlubG1zdmNfZ3JhY2VfcGVyaW9k
ID0gMDsKICB9CiAgCisgCiAgLyoKICAgKiBUaGlzIGlzIHRoZSBsb2NrZCBrZXJuZWwgdGhyZWFk
CiAgICovCioqKioqKioqKioqKioqKgoqKiogODUsOTEgKioqKgogIHsKICAJc3RydWN0IHN2Y19z
ZXJ2CSpzZXJ2ID0gcnFzdHAtPnJxX3NlcnZlcjsKICAJaW50CQllcnIgPSAwOwotIAl1bnNpZ25l
ZCBsb25nIGdyYWNlX3BlcmlvZF9leHBpcmU7CiAgCiAgCS8qIExvY2sgbW9kdWxlIGFuZCBzZXQg
dXAga2VybmVsIHRocmVhZCAqLwogIAlNT0RfSU5DX1VTRV9DT1VOVDsKLS0tIDEwMCwxMDUgLS0t
LQoqKioqKioqKioqKioqKioKKioqIDIyOCwyMzMgKioqKgotLS0gMjQyLDI0OSAtLS0tCiAgCWlm
IChubG1zdmNfcGlkKQogIAkJZ290byBvdXQ7CiAgCisgCWxvY2tkX3JlZ2lzdGVyX3N5c2N0bCgp
OworIAogIAkvKgogIAkgKiBTYW5pdHkgY2hlY2s6IGlmIHRoZXJlJ3Mgbm8gcGlkLAogIAkgKiB3
ZSBzaG91bGQgYmUgdGhlIGZpcnN0IHVzZXIgLi4uCioqKioqKioqKioqKioqKgoqKiogMjkxLDI5
NiAqKioqCi0tLSAzMDcsMzE0IC0tLS0KICAJCQlnb3RvIG91dDsKICAJfSBlbHNlCiAgCQlwcmlu
dGsoS0VSTl9XQVJOSU5HICJsb2NrZF9kb3duOiBubyB1c2VycyEgcGlkPSVkXG4iLCBubG1zdmNf
cGlkKTsKKyAKKyAJbG9ja2RfZGVyZWdpc3Rlcl9zeXNjdGwoKTsKICAKICAJaWYgKCFubG1zdmNf
cGlkKSB7CiAgCQlpZiAod2FybmVkKysgPT0gMCkKZGlmZiAtcmNOIGxpbnV4LTIuNC4xOS9mcy9s
b2NrZC9zeXNjdGwuYyBsaW51eC0yLjQuMTktbG9ja2Qtc3lzY3RsL2ZzL2xvY2tkL3N5c2N0bC5j
CioqKiBsaW51eC0yLjQuMTkvZnMvbG9ja2Qvc3lzY3RsLmMJV2VkIERlYyAzMSAxNjowMDowMCAx
OTY5Ci0tLSBsaW51eC0yLjQuMTktbG9ja2Qtc3lzY3RsL2ZzL2xvY2tkL3N5c2N0bC5jCUZyaSBT
ZXAgIDYgMTk6MDg6MTggMjAwMgoqKioqKioqKioqKioqKioKKioqIDAgKioqKgotLS0gMSwxNTcg
LS0tLQorIAorICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgorICNpbmNsdWRlIDxsaW51eC9jdHlw
ZS5oPgorICNpbmNsdWRlIDxsaW51eC9zeXNjdGwuaD4KKyAjaW5jbHVkZSA8YXNtL2Vycm5vLmg+
CisgI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CisgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgor
ICNpbmNsdWRlIDxsaW51eC9maWxlLmg+CisgCisgc3RhdGljIHN0cnVjdCBjdGxfdGFibGVfaGVh
ZGVyICAqbG9ja2RfdGFibGVfaGVhZGVyOworIHN0YXRpYyBjdGxfdGFibGUJCWxvY2tkX3RhYmxl
W107CisgCisgLyogU3R1ZmYgaW1wb3J0ZWQgZnJvbSBzdmMuYyAqLworIAorIGV4dGVybiBpbmxp
bmUgdm9pZCBzdGFydF9ncmFjZV9wZXJpb2Qodm9pZCk7CisgZXh0ZXJuIGlubGluZSB2b2lkIGNs
ZWFyX2dyYWNlX3BlcmlvZCh2b2lkKTsKKyBleHRlcm4gaW50IG5sbXN2Y19ncmFjZV9wZXJpb2Q7
CisgCisgCisgLyogUmVnaXN0ZXIgd2l0aCBzeXNjdGwgc28gd2UgY2FuIGV4cG9ydCBjb250cm9s
IG9mIGxvY2tkIHRvIHVzZXItbGFuZAorICAqIHZpYSAvcHJvYy9zeXMKKyAgKi8KKyAKKyB2b2lk
IGxvY2tkX3JlZ2lzdGVyX3N5c2N0bCgpCisgeworIAorICAgaWYgKCFsb2NrZF90YWJsZV9oZWFk
ZXIpIHsKKyAKKyAgICAgcHJpbnRrKCJsb2NrZF9yZWdpc3Rlcl9zeXNjdGw6PT5yZWdpc3Rlcl9z
eXNjdGxfdGFibGUoKVxuIik7CisgICAgIGxvY2tkX3RhYmxlX2hlYWRlciA9IHJlZ2lzdGVyX3N5
c2N0bF90YWJsZShsb2NrZF90YWJsZSwgMSk7CisgCisgICB9CisgCQorIAorIH0vKiB2b2lkIGxv
Y2tkX3JlZ2lzdGVyX3N5c2N0bCgpICovCisgCisgCisgCisgCisgLyogRGUtcmVnaXN0ZXIgd2l0
aCBzeXNjdGwgc28gd2UgZG8gbm90IGhhdmUgc3RhbGUgZW50cmllcyBpbiAKKyAgKiAvcHJvYy9z
eXMKKyAgKi8KKyAKKyB2b2lkIGxvY2tkX2RlcmVnaXN0ZXJfc3lzY3RsKCkKKyB7CisgCisgCWlm
IChsb2NrZF90YWJsZV9oZWFkZXIpIHsKKyAJICAgICAgICBwcmludGsoImxvY2tkX2RlcmVnaXN0
ZXJfc3lzY3RsOj0+cmVnaXN0ZXJfc3lzY3RsX3RhYmxlKClcbiIpOworIAkJdW5yZWdpc3Rlcl9z
eXNjdGxfdGFibGUobG9ja2RfdGFibGVfaGVhZGVyKTsKKyAJCWxvY2tkX3RhYmxlX2hlYWRlciA9
IE5VTEw7CisgCX0KKyAKKyB9Lyogdm9pZCBsb2NrZF9kZXJlZ2lzdGVyX3N5c2N0bCgpICovCisg
Cisgc3RhdGljIGludAorIHByb2NfZG9fbG9ja2RfZ3JhY2VfcGVyaW9kKGN0bF90YWJsZSAqdGFi
bGUsIAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCB3cml0ZSwgCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGZpbGUgKmZpbGUsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdm9pZCAqYnVmZmVyLCAKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
X3QgKmxlbnApCisgeworIAljaGFyCQl0bXBidWZbMjBdLCAqcCwgYzsKKyAJdW5zaWduZWQgaW50
CXZhbHVlOworIAlzaXplX3QJCWxlZnQsIGxlbjsKKyAKKyAJcHJpbnRrKCJwcm9jX2RvX2xvY2tk
X2dyYWNlX3BlcmlvZDogd3JpdGU9JWQsIGxlbnA9JXAsIGJ1ZmZlcj0lcFxuIiwKKyAJICAgICAg
IHdyaXRlLCBsZW5wLCBidWZmZXIpOworIAlwcmludGsoInByb2NfZG9fbG9ja2RfZ3JhY2VfcGVy
aW9kOiBsZW49JWRcbiIsIGxlbnAgPyAqbGVucCA6IDApOworIAorIAlpZiAoKGZpbGUtPmZfcG9z
ICYmICF3cml0ZSkgfHwgISpsZW5wKSB7CisgCQkqbGVucCA9IDA7CisgCQlyZXR1cm4gMDsKKyAJ
fQorIAorIAlsZWZ0ID0gKmxlbnA7CisgCisgCWlmICh3cml0ZSkgeworIAorICAgICAgICAgICBp
ZiAoIWFjY2Vzc19vayhWRVJJRllfV1JJVEUsIGJ1ZmZlciwgbGVmdCkpCisgICAgICAgICAgICAg
cmV0dXJuIC1FRkFVTFQ7CisgICAgICAgICAgIHAgPSAoY2hhciAqKSBidWZmZXI7CisgICAgICAg
ICAgIHdoaWxlIChsZWZ0ICYmIF9fZ2V0X3VzZXIoYywgcCkgPj0gMCAmJiBpc3NwYWNlKGMpKQor
ICAgICAgICAgICAgIGxlZnQtLSwgcCsrOworICAgICAgICAgICBpZiAoIWxlZnQpCisgICAgICAg
ICAgICAgZ290byBkb25lOworICAgICAgICAgICAKKyAgICAgICAgICAgaWYgKGxlZnQgPiBzaXpl
b2YodG1wYnVmKSAtIDEpCisgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CisgICAgICAgICAg
IGNvcHlfZnJvbV91c2VyKHRtcGJ1ZiwgcCwgbGVmdCk7CisgICAgICAgICAgIHRtcGJ1ZltsZWZ0
XSA9ICdcMCc7CisgCisgCisgCSAgZm9yIChwID0gdG1wYnVmLCB2YWx1ZSA9IDA7ICcwJyA8PSAq
cCAmJiAqcCA8PSAnOSc7IHArKywgbGVmdC0tKQorIAkgICAgdmFsdWUgPSAxMCAqIHZhbHVlICsg
KCpwIC0gJzAnKTsKKyAJICBpZiAoKnAgJiYgIWlzc3BhY2UoKnApKQorIAkgICAgcmV0dXJuIC1F
SU5WQUw7CisgCSAgd2hpbGUgKGxlZnQgJiYgaXNzcGFjZSgqcCkpCisgCSAgICBsZWZ0LS0sIHAr
KzsKKyAKKyAgICAgICAgICAgaWYgKHZhbHVlID09IDApIHsKKyAKKyAgICAgICAgICAgICBjbGVh
cl9ncmFjZV9wZXJpb2QoKTsKKyAKKyAgICAgICAgICAgfSBlbHNlIGlmKHZhbHVlID09IDEpIHsK
KyAKKyAgICAgICAgICAgICBzdGFydF9ncmFjZV9wZXJpb2QoKTsKKyAKKyAgICAgICAgICAgfSBl
bHNlIHsKKyAKKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKKyAKKyAgICAgICAgICAgfQor
ICAgICAgICAgICAKKyAKKyAJfSBlbHNlIHsKKyAgICAgICAgICAgLyogUmVhZCBBY2Nlc3MgKi8K
KyAKKyAJICBwcmludGsoInByb2NfZG9fbG9ja2RfZ3JhY2VfcGVyaW9kOiByZWFkaW5nLi4uXG4i
KTsKKyAKKyAgICAgICAgICAgaWYgKCFhY2Nlc3Nfb2soVkVSSUZZX1JFQUQsIGJ1ZmZlciwgbGVm
dCkpCisgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7CisgCisgICAgICAgICAgIGxlbiA9IHNw
cmludGYodG1wYnVmLCAiJWQiLCBubG1zdmNfZ3JhY2VfcGVyaW9kKTsKKyAgICAgICAgICAgaWYg
KGxlbiA+IGxlZnQpCisgICAgICAgICAgICAgbGVuID0gbGVmdDsKKyAgICAgICAgICAgY29weV90
b191c2VyKGJ1ZmZlciwgdG1wYnVmLCBsZW4pOworICAgICAgICAgICBpZiAoKGxlZnQgLT0gbGVu
KSA+IDApIHsKKyAgICAgICAgICAgICBwdXRfdXNlcignXG4nLCAoY2hhciAqKWJ1ZmZlciArIGxl
bik7CisgICAgICAgICAgICAgbGVmdC0tOworICAgICAgICAgICB9CisgCX0KKyAKKyBkb25lOgor
IAkqbGVucCAtPSBsZWZ0OworIAlmaWxlLT5mX3BvcyArPSAqbGVucDsKKyAJcmV0dXJuIDA7Cisg
CisgfS8qc3RhdGljIGludCBwcm9jX2RvX2xvY2tkX3N5c2N0bCgpICovCisgCisgLyogRGVmaW5l
IGRpciBzdHJ1Y3R1cmUgd2Ugd2FudCB0byBleHBvcnQgdGhyb3VnaCAvcHJvYy9mcyAqLworIAor
ICNkZWZpbmUgRElSRU5UUlkobmFtMSwgbmFtMiwgY2hpbGQpCVwKKyAJe0NUTF8jI25hbTEsICNu
YW0yLCBOVUxMLCAwLCAwNTU1LCBjaGlsZCB9CisgI2RlZmluZSBMT0NLRF9GSUxFX0VOVFJZKG5h
bTEsIG5hbTIpCVwKKyAJe0xPQ0tEX0NUTF8jI25hbTEjIywgImxvY2tkXyIgI25hbTIsIE5VTEws
IDAsXAorIAkgMDY0NCwgTlVMTCwgJnByb2NfZG9fbG9ja2RfZ3JhY2VfcGVyaW9kfQorIAorIHN0
YXRpYyBjdGxfdGFibGUJCWxvY2tkX2ZpbGVfdGFibGVbXSA9IHsKKyAJTE9DS0RfRklMRV9FTlRS
WShHUkFDRV9QRVJJT0QsICBncmFjZV9wZXJpb2QpLAorIAl7MH0KKyB9OworIAorIHN0YXRpYyBj
dGxfdGFibGUJCWxvY2tkX3RhYmxlW10gPSB7CisgCURJUkVOVFJZKExPQ0tELCBsb2NrZCwgbG9j
a2RfZmlsZV90YWJsZSksCisgCXswfQorIH07CisgCmRpZmYgLXJjTiBsaW51eC0yLjQuMTkvaW5j
bHVkZS9saW51eC9zeXNjdGwuaCBsaW51eC0yLjQuMTktbG9ja2Qtc3lzY3RsL2luY2x1ZGUvbGlu
dXgvc3lzY3RsLmgKKioqIGxpbnV4LTIuNC4xOS9pbmNsdWRlL2xpbnV4L3N5c2N0bC5oCUZyaSBB
dWcgIDIgMTc6Mzk6NDYgMjAwMgotLS0gbGludXgtMi40LjE5LWxvY2tkLXN5c2N0bC9pbmNsdWRl
L2xpbnV4L3N5c2N0bC5oCUZyaSBTZXAgIDYgMjE6NDc6NDMgMjAwMgoqKioqKioqKioqKioqKioK
KioqIDYzLDY5ICoqKioKICAJQ1RMX0RFVj03LAkJLyogRGV2aWNlcyAqLwogIAlDVExfQlVTPTgs
CQkvKiBCdXNzZXMgKi8KICAJQ1RMX0FCST05LAkJLyogQmluYXJ5IGVtdWxhdGlvbiAqLwohIAlD
VExfQ1BVPTEwCQkvKiBDUFUgc3R1ZmYgKHNwZWVkIHNjYWxpbmcsIGV0YykgKi8KICB9OwogIAog
IC8qIENUTF9CVVMgbmFtZXM6ICovCi0tLSA2Myw3MCAtLS0tCiAgCUNUTF9ERVY9NywJCS8qIERl
dmljZXMgKi8KICAJQ1RMX0JVUz04LAkJLyogQnVzc2VzICovCiAgCUNUTF9BQkk9OSwJCS8qIEJp
bmFyeSBlbXVsYXRpb24gKi8KISAJQ1RMX0NQVT0xMCwJCS8qIENQVSBzdHVmZiAoc3BlZWQgc2Nh
bGluZywgZXRjKSAqLwohICAgICAgICAgQ1RMX0xPQ0tEPTExLCAgICAgICAgICAgLyogTG9ja2Qg
aW5mbyBhbmQgY29udHJvbCAqLwogIH07CiAgCiAgLyogQ1RMX0JVUyBuYW1lczogKi8KKioqKioq
KioqKioqKioqCioqKiA2MjcsNjMyICoqKioKLS0tIDYyOCw2NDEgLS0tLQogIAlBQklfVFJBQ0U9
NSwJCS8qIHRyYWNpbmcgZmxhZ3MgKi8KICAJQUJJX0ZBS0VfVVRTTkFNRT02LAkvKiBmYWtlIHRh
cmdldCB1dHNuYW1lIGluZm9ybWF0aW9uICovCiAgfTsKKyAKKyAKKyAvKiAvcHJvYy9zeXMvbG9j
a2QgKi8KKyBlbnVtCisgeworICAgICAgICAgTE9DS0RfQ1RMX0dSQUNFX1BFUklPRD0xLC8qIEVu
YWJsZSB1c2VyLWxldmVsIGdyYWNlIHBlcmlvZCBjb250cm9sICovCisgfTsKKyAKICAKICAjaWZk
ZWYgX19LRVJORUxfXwogIAo=

--0__=08BBE6BFDFE8ABA08f9e8a93df938690918c08BBE6BFDFE8ABA0--

