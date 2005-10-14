Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVJNMXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVJNMXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 08:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVJNMXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 08:23:43 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:41998 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbVJNMXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 08:23:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EoRYqK3NAsJLZTXURu9PuJMUHwSy6T8EBl+RIUBP6TNvowBcqq6sMm2J9iLim3HwWfYXZPLnmLBSLnChfsBtKc2n/0aZlrZHWXSo84B7++rYfthfHzuqu2gl+hMVyjpPMlq1Um+sHj+i1USopXqkry9VgPPcfQXuq4kk+pyAqfY=
Message-ID: <9a8748490510140523u3a0b41f1ueaf2f83b48abcc69@mail.gmail.com>
Date: Fri, 14 Oct 2005 14:23:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 11/14] Big kfree NULL check cleanup - arch
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>,
       Ralf Baechle <ralf@linux-mips.org>,
       Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@karaya.com>
In-Reply-To: <20051014114722.GB16113@parisc-linux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23573_13596687.1129292621608"
References: <200510132129.40176.jesper.juhl@gmail.com>
	 <20051014114722.GB16113@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_23573_13596687.1129292621608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/14/05, Matthew Wilcox <matthew@wil.cx> wrote:
> On Thu, Oct 13, 2005 at 09:29:39PM +0200, Jesper Juhl wrote:
> > This is the arch/ part of the big kfree cleanup patch.
>
> Ignore the parisc part; it conflicts with simply deleting that code
> (patch from hch).
>
Attached is a patch to revert that.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_23573_13596687.1129292621608
Content-Type: text/x-patch; name="revert-kfree-parisc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="revert-kfree-parisc.patch"

LS0tIGxpbnV4LTIuNi4xNC1yYzQvYXJjaC9wYXJpc2Mva2VybmVsL2lvY3RsMzIuYy5hCTIwMDUt
MTAtMTQgMTQ6MjQ6MTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTQtcmM0L2FyY2gv
cGFyaXNjL2tlcm5lbC9pb2N0bDMyLmMJMjAwNS0xMC0xNCAxNDoyNDoxOS4wMDAwMDAwMDAgKzAy
MDAKQEAgLTEwNCw5ICsxMDQsMTIgQEAgc3RhdGljIGludCBkcm0zMl92ZXJzaW9uKHVuc2lnbmVk
IGludCBmZAogCX0KIAogb3V0OgotCWtmcmVlKGt2ZXJzaW9uLm5hbWUpOwotCWtmcmVlKGt2ZXJz
aW9uLmRhdGUpOwotCWtmcmVlKGt2ZXJzaW9uLmRlc2MpOworCWlmIChrdmVyc2lvbi5uYW1lKQor
CQlrZnJlZShrdmVyc2lvbi5uYW1lKTsKKwlpZiAoa3ZlcnNpb24uZGF0ZSkKKwkJa2ZyZWUoa3Zl
cnNpb24uZGF0ZSk7CisJaWYgKGt2ZXJzaW9uLmRlc2MpCisJCWtmcmVlKGt2ZXJzaW9uLmRlc2Mp
OwogCXJldHVybiByZXQ7CiB9CiAKQEAgLTE2Myw3ICsxNjYsOSBAQCBzdGF0aWMgaW50IGRybTMy
X2dldHNldHVuaXF1ZSh1bnNpZ25lZCBpCiAJCQlyZXQgPSAtRUZBVUxUOwogCX0KIAotCWtmcmVl
KGthcmcudW5pcXVlKTsKKwlpZiAoa2FyZy51bmlxdWUgIT0gTlVMTCkKKwkJa2ZyZWUoa2FyZy51
bmlxdWUpOworCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMjYwLDYgKzI2NSw3IEBAIHN0YXRpYyBp
bnQgZHJtMzJfaW5mb19idWZzKHVuc2lnbmVkIGludCAKIAl9CiAKIAlrZnJlZShrYXJnLmxpc3Qp
OworCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMjk5LDYgKzMwNSw3IEBAIHN0YXRpYyBpbnQgZHJt
MzJfZnJlZV9idWZzKHVuc2lnbmVkIGludCAKIAogb3V0OgogCWtmcmVlKGthcmcubGlzdCk7CisK
IAlyZXR1cm4gcmV0OwogfQogCkBAIC00ODcsMTAgKzQ5NCwxNSBAQCBzdGF0aWMgaW50IGRybTMy
X2RtYSh1bnNpZ25lZCBpbnQgZmQsIHVuCiAJfQogCiBvdXQ6Ci0Ja2ZyZWUoa2FyZy5zZW5kX2lu
ZGljZXMpOwotCWtmcmVlKGthcmcuc2VuZF9zaXplcyk7Ci0Ja2ZyZWUoa2FyZy5yZXF1ZXN0X2lu
ZGljZXMpOwotCWtmcmVlKGthcmcucmVxdWVzdF9zaXplcyk7CisJaWYgKGthcmcuc2VuZF9pbmRp
Y2VzKQorCQlrZnJlZShrYXJnLnNlbmRfaW5kaWNlcyk7CisJaWYgKGthcmcuc2VuZF9zaXplcykK
KwkJa2ZyZWUoa2FyZy5zZW5kX3NpemVzKTsKKwlpZiAoa2FyZy5yZXF1ZXN0X2luZGljZXMpCisJ
CWtmcmVlKGthcmcucmVxdWVzdF9pbmRpY2VzKTsKKwlpZiAoa2FyZy5yZXF1ZXN0X3NpemVzKQor
CQlrZnJlZShrYXJnLnJlcXVlc3Rfc2l6ZXMpOworCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtNTQz
LDcgKzU1NSw5IEBAIHN0YXRpYyBpbnQgZHJtMzJfcmVzX2N0eCh1bnNpZ25lZCBpbnQgZmQKIAkJ
CXJldCA9IC1FRkFVTFQ7CiAJfQogCi0Ja2ZyZWUoa2FyZy5jb250ZXh0cyk7CisJaWYgKGthcmcu
Y29udGV4dHMpCisJCWtmcmVlKGthcmcuY29udGV4dHMpOworCiAJcmV0dXJuIHJldDsKIH0KIAo=

------=_Part_23573_13596687.1129292621608--
