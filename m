Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284975AbRLQCvL>; Sun, 16 Dec 2001 21:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284973AbRLQCvC>; Sun, 16 Dec 2001 21:51:02 -0500
Received: from nat.transgeek.com ([66.92.79.28]:30203 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S284975AbRLQCuu>;
	Sun, 16 Dec 2001 21:50:50 -0500
From: Craig Christophel <merlin@transgeek.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.1 - intermediate bio stuff..
Date: Sun, 16 Dec 2001 21:52:25 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112161604030.11129-100000@penguin.transmeta.com> <200112170221.fBH2LAx01188@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200112170221.fBH2LAx01188@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DZVG5BA9BE6GXP3MBYAD"
Message-Id: <20011216225008.69B50C7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DZVG5BA9BE6GXP3MBYAD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I have a patch for the nfs stuff.   It's just a couple of EXPORT_SYMBOL lines 
in the seq_file.c.



Craig.



On Sunday 16 December 2001 21:21, Richard Gooch wrote:
> Linus Torvalds writes:
> > 2.5.1 is hopefully a good interim stage - many block drivers should
> > work fine, but many more do not.  However, the pre-patches were
> > getting largish, so I'd rather do a 2.5.1 than wait for all the
> > details.
>
> Trying a quick test-run here:
> # modprobe ide-probe-mod
> /lib/modules/2.5.1/kernel/drivers/ide/ide-mod.o: unresolved symbol
> block_ioctl
>
> # modprobe ide-cd
> /lib/modules/2.5.1/kernel/drivers/ide/ide-mod.o: unresolved symbol
> block_ioctl
>
> # modprobe ide-disk
> /lib/modules/2.5.1/kernel/drivers/ide/ide-mod.o: unresolved symbol
> block_ioctl
>
> # modprobe nfs
> /lib/modules/2.5.1/kernel/fs/nfs/nfs.o: unresolved symbol seq_escape
> /lib/modules/2.5.1/kernel/fs/nfs/nfs.o: unresolved symbol seq_printf
>
> 				Regards,
>
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------Boundary-00=_DZVG5BA9BE6GXP3MBYAD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nfs-module-2.5-unresolved-symbols.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nfs-module-2.5-unresolved-symbols.diff"

ZGlmZiAtdXJOIGxpbnV4L2ZzL01ha2VmaWxlIGxpbnV4Lm10L2ZzL01ha2VmaWxlCi0tLSBsaW51
eC9mcy9NYWtlZmlsZQlTdW4gRGVjICA5IDIzOjU3OjI0IDIwMDEKKysrIGxpbnV4Lm10L2ZzL01h
a2VmaWxlCU1vbiBEZWMgMTAgMjI6MTg6MzEgMjAwMQpAQCAtNyw3ICs3LDcgQEAKIAogT19UQVJH
RVQgOj0gZnMubwogCi1leHBvcnQtb2JqcyA6PQlmaWxlc3lzdGVtcy5vIG9wZW4ubyBkY2FjaGUu
byBidWZmZXIubyBiaW8ubworZXhwb3J0LW9ianMgOj0JZmlsZXN5c3RlbXMubyBvcGVuLm8gZGNh
Y2hlLm8gYnVmZmVyLm8gYmlvLm8gc2VxX2ZpbGUubwogbW9kLXN1YmRpcnMgOj0JbmxzCiAKIG9i
ai15IDo9CW9wZW4ubyByZWFkX3dyaXRlLm8gZGV2aWNlcy5vIGZpbGVfdGFibGUubyBidWZmZXIu
byBcCmRpZmYgLXVyTiBsaW51eC9mcy9zZXFfZmlsZS5jIGxpbnV4Lm10L2ZzL3NlcV9maWxlLmMK
LS0tIGxpbnV4L2ZzL3NlcV9maWxlLmMJU2F0IE5vdiAxNyAyMToxNjoyMiAyMDAxCisrKyBsaW51
eC5tdC9mcy9zZXFfZmlsZS5jCVR1ZSBEZWMgMTEgMDA6Mzk6MDkgMjAwMQpAQCAtOCw2ICs4LDcg
QEAKICNpbmNsdWRlIDxsaW51eC9mcy5oPgogI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+CiAj
aW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogCiAjaW5j
bHVkZSA8YXNtL3VhY2Nlc3MuaD4KIApAQCAtMjkzLDMgKzI5NCw5IEBACiAJbS0+Y291bnQgPSBt
LT5zaXplOwogCXJldHVybiAtMTsKIH0KK0VYUE9SVF9TWU1CT0woc2VxX3ByaW50Zik7CitFWFBP
UlRfU1lNQk9MKHNlcV9lc2NhcGUpOworRVhQT1JUX1NZTUJPTChzZXFfcmVsZWFzZSk7CitFWFBP
UlRfU1lNQk9MKHNlcV9sc2Vlayk7CitFWFBPUlRfU1lNQk9MKHNlcV9vcGVuKTsKK0VYUE9SVF9T
WU1CT0woc2VxX3JlYWQpOwpkaWZmIC11ck4gbGludXgvaW5jbHVkZS9saW51eC9zZXFfZmlsZS5o
IGxpbnV4Lm10L2luY2x1ZGUvbGludXgvc2VxX2ZpbGUuaAotLS0gbGludXgvaW5jbHVkZS9saW51
eC9zZXFfZmlsZS5oCVN1biBEZWMgIDkgMjM6NTc6MjQgMjAwMQorKysgbGludXgubXQvaW5jbHVk
ZS9saW51eC9zZXFfZmlsZS5oCU1vbiBEZWMgMTAgMjM6NDc6MTUgMjAwMQpAQCAtMjYsMTEgKzI2
LDExIEBACiAJaW50ICgqc2hvdykgKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdik7CiB9Owog
Ci1pbnQgc2VxX29wZW4oc3RydWN0IGZpbGUgKiwgc3RydWN0IHNlcV9vcGVyYXRpb25zICopOwot
c3NpemVfdCBzZXFfcmVhZChzdHJ1Y3QgZmlsZSAqLCBjaGFyICosIHNpemVfdCwgbG9mZl90ICop
OwotbG9mZl90IHNlcV9sc2VlayhzdHJ1Y3QgZmlsZSAqLCBsb2ZmX3QsIGludCk7Ci1pbnQgc2Vx
X3JlbGVhc2Uoc3RydWN0IGlub2RlICosIHN0cnVjdCBmaWxlICopOwotaW50IHNlcV9lc2NhcGUo
c3RydWN0IHNlcV9maWxlICosIGNvbnN0IGNoYXIgKiwgY29uc3QgY2hhciAqKTsKK2V4dGVybiBp
bnQgc2VxX29wZW4oc3RydWN0IGZpbGUgKiwgc3RydWN0IHNlcV9vcGVyYXRpb25zICopOworZXh0
ZXJuIHNzaXplX3Qgc2VxX3JlYWQoc3RydWN0IGZpbGUgKiwgY2hhciAqLCBzaXplX3QsIGxvZmZf
dCAqKTsKK2V4dGVybiBsb2ZmX3Qgc2VxX2xzZWVrKHN0cnVjdCBmaWxlICosIGxvZmZfdCwgaW50
KTsKK2V4dGVybiBpbnQgc2VxX3JlbGVhc2Uoc3RydWN0IGlub2RlICosIHN0cnVjdCBmaWxlICop
OworZXh0ZXJuIGludCBzZXFfZXNjYXBlKHN0cnVjdCBzZXFfZmlsZSAqLCBjb25zdCBjaGFyICos
IGNvbnN0IGNoYXIgKik7CiAKIHN0YXRpYyBpbmxpbmUgaW50IHNlcV9wdXRjKHN0cnVjdCBzZXFf
ZmlsZSAqbSwgY2hhciBjKQogewpAQCAtNTMsNyArNTMsNyBAQAogCXJldHVybiAtMTsKIH0KIAot
aW50IHNlcV9wcmludGYoc3RydWN0IHNlcV9maWxlICosIGNvbnN0IGNoYXIgKiwgLi4uKQorZXh0
ZXJuIGludCBzZXFfcHJpbnRmKHN0cnVjdCBzZXFfZmlsZSAqLCBjb25zdCBjaGFyICosIC4uLikK
IAlfX2F0dHJpYnV0ZV9fICgoZm9ybWF0IChwcmludGYsMiwzKSkpOwogCiAjZW5kaWYK

--------------Boundary-00=_DZVG5BA9BE6GXP3MBYAD--
