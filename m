Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWCSKlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWCSKlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 05:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWCSKlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 05:41:49 -0500
Received: from smtp2.home.se ([212.78.199.22]:25027 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id S1751384AbWCSKls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 05:41:48 -0500
Date: Sun, 19 Mar 2006 11:41:24 +0100
From: Martin Samuelsson <sam@home.se>
To: "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: saa7111.c patch
Message-Id: <20060319114124.11d4fa9d.sam@home.se>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__19_Mar_2006_11_41_24_+0100_anPXxZ61JEkwRuDZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__19_Mar_2006_11_41_24_+0100_anPXxZ61JEkwRuDZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello.

When grabbing composite video with Iomega Buz, the stock driver will prevent grabbing from the same input twice in a row, forcing the user to switch inputs before anything useful can be grabbed again. It is caused by some optimization code in the input selection parts, and triggered by the saa7111_command() executing cmd 0. The attached patch will remedy this by disabling cmd 0 altogether; a fix that has no found negative effects on the rest of the code. In fact, saa7110.c does the exact same thing.

It would be nice to have this included in the kernel driver.

I'd appreciate being kept in the recipient list in case of discussion.

Regards,
/Sam


--Multipart=_Sun__19_Mar_2006_11_41_24_+0100_anPXxZ61JEkwRuDZ
Content-Type: application/octet-stream;
 name="linux-2.6.15.6-buz.diff"
Content-Disposition: attachment;
 filename="linux-2.6.15.6-buz.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xNS42L2RyaXZlcnMvbWVkaWEvdmlkZW8vc2FhNzExMS5jCTIwMDYtMDMt
MDUgMjA6MDc6NTQuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMTUuNi1idXovZHJpdmVy
cy9tZWRpYS92aWRlby9zYWE3MTExLmMJMjAwNi0wMy0xOSAwMjoxODoyNy4wMDAwMDAwMDAgKzAx
MDAKQEAgLTIxMCw2ICsyMTAsNyBAQAogCXN3aXRjaCAoY21kKSB7CiAKIAljYXNlIDA6CisJICBi
cmVhazsKIAljYXNlIERFQ09ERVJfSU5JVDoKIAl7CiAJCXN0cnVjdCB2aWRlb19kZWNvZGVyX2lu
aXQgKmluaXQgPSBhcmc7Cg==

--Multipart=_Sun__19_Mar_2006_11_41_24_+0100_anPXxZ61JEkwRuDZ--
