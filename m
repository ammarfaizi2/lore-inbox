Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUDOTXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUDOTXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:23:51 -0400
Received: from colino.net ([62.212.100.143]:60150 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262339AbUDOTXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:23:48 -0400
Date: Thu, 15 Apr 2004 21:23:34 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.6-rc1: cdc-acm still (differently) broken
Message-Id: <20040415212334.4a568c5a@jack.colino.net>
In-Reply-To: <407EDA4A.2070509@pacbell.net>
References: <20040415201117.11524f63@jack.colino.net>
	<407EDA4A.2070509@pacbell.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__15_Apr_2004_21_23_34_+0200_IbGh=K08W_=Am5Pt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__15_Apr_2004_21_23_34_+0200_IbGh=K08W_=Am5Pt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 15 Apr 2004 at 11h04, David Brownell wrote:

Hi David, 

> That test has always been buggy -- better to just remove it.  For
> that matter, usb_interface_claimed() calls should all vanish ... it's
> better to fail if claiming the interface fails (one step, not two).
> Care to try an updated patch?

Like this one? It works. I'm a bit wondering, however, how comes 
usb_interface_claimed() returns true, and the check in 
usb_driver_claim_interface() passes?


-- 
Colin

--Multipart=_Thu__15_Apr_2004_21_23_34_+0200_IbGh=K08W_=Am5Pt
Content-Type: application/octet-stream;
 name="cdc-acm.patch"
Content-Disposition: attachment;
 filename="cdc-acm.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYy5vcmlnCTIwMDQtMDQtMTUgMjA6MDQ6NDcu
MDAwMDAwMDAwICswMjAwCisrKyBkcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmMJMjAwNC0wNC0x
NSAyMToyMDowMC4yNTUxMjM2MTYgKzAyMDAKQEAgLTU4NSwxMCArNTg1LDYgQEAKIAogCQlmb3Ig
KGogPSAwOyBqIDwgY2ZhY20tPmRlc2MuYk51bUludGVyZmFjZXMgLSAxOyBqKyspIHsKIAkJICAg
IAotCQkJaWYgKHVzYl9pbnRlcmZhY2VfY2xhaW1lZChjZmFjbS0+aW50ZXJmYWNlW2pdKSB8fAot
CQkJICAgIHVzYl9pbnRlcmZhY2VfY2xhaW1lZChjZmFjbS0+aW50ZXJmYWNlW2ogKyAxXSkpCi0J
CQkJY29udGludWU7Ci0KIAkJCS8qIFdlIGtub3cgd2UncmUgcHJvYmUoKWQgd2l0aCB0aGUgY29u
dHJvbCBpbnRlcmZhY2UuCiAJCQkgKiBGSVhNRSBBQ00gZG9lc24ndCBndWFyYW50ZWUgdGhlIGRh
dGEgaW50ZXJmYWNlIGlzCiAJCQkgKiBhZGphY2VudCB0byB0aGUgY29udHJvbCBpbnRlcmZhY2Us
IG9yIHRoYXQgaWYgb25lCkBAIC02OTYsNyArNjkyLDEzIEBACiAJCQlhY20tPmxpbmUuZGF0YWJp
dHMgPSA4OwogCQkJYWNtX3NldF9saW5lKGFjbSwgJmFjbS0+bGluZSk7CiAKLQkJCXVzYl9kcml2
ZXJfY2xhaW1faW50ZXJmYWNlKCZhY21fZHJpdmVyLCBkYXRhLCBhY20pOworCQkJaWYgKCAoaiA9
IHVzYl9kcml2ZXJfY2xhaW1faW50ZXJmYWNlKCZhY21fZHJpdmVyLCBkYXRhLCBhY20pKSAhPSAw
KSB7CisJCQkJZXJyKCJjbGFpbSBmYWlsZWQiKTsKKwkJCQl1c2JfZnJlZV91cmIoYWNtLT5jdHJs
dXJiKTsKKwkJCQlrZnJlZShhY20pOworCQkJCWtmcmVlKGJ1Zik7CisJCQkJcmV0dXJuIGo7CisJ
CQl9IAogCiAJCQl0dHlfcmVnaXN0ZXJfZGV2aWNlKGFjbV90dHlfZHJpdmVyLCBtaW5vciwgJmlu
dGYtPmRldik7CiAK

--Multipart=_Thu__15_Apr_2004_21_23_34_+0200_IbGh=K08W_=Am5Pt--
