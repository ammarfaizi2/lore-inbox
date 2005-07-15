Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263328AbVGORbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbVGORbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbVGORbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:31:00 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:48078 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263328AbVGORa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:30:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=LjfpSB77FanA6OPyQznd8AIjJXf0JfJbbPP6VocqiqYwnv51JVjY3TY6aMITni/BYrfOg0IwS7nEe4kWCXLKPaSjsqv8nhJyCPeF+cvcyJ6ymG6UoMD82RHbRKKq7aHTX/o7H3Kd+hpRgbzaO0ndVpWUooL6jdmfMznHUoU9GPI=
Message-ID: <9cde8bff05071510307c7beb4@mail.gmail.com>
Date: Sat, 16 Jul 2005 02:30:57 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memparse bugfix
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4421_14431686.1121448657857"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4421_14431686.1121448657857
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Function lib/cmdline.c:memparse() wrongly calculates the memory if the
given string has K/M/G suffix. This patch (against 2.6.13-rc3) fixes
the problem. Please apply.

Signed-off-by: Nguyen Anh Quynh <aquynh@gmail.com>


# diffstat cmdline.patch=20
 cmdline-aq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

------=_Part_4421_14431686.1121448657857
Content-Type: application/octet-stream; name="cmdline.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cmdline.patch"

LS0tIDIuNi4xMy1yYzMvbGliL2NtZGxpbmUuYwkyMDA1LTA0LTMwIDEwOjMxOjM3LjAwMDAwMDAw
MCArMDkwMAorKysgMi42LjEzLXJjMy9saWIvY21kbGluZS1hcS5jCTIwMDUtMDctMTYgMDI6MjU6
MjYuMDAwMDAwMDAwICswOTAwCkBAIC0xMDAsMTAgKzEwMCwxMCBAQCB1bnNpZ25lZCBsb25nIGxv
bmcgbWVtcGFyc2UgKGNoYXIgKnB0ciwgCiAJc3dpdGNoICgqKnJldHB0cikgewogCWNhc2UgJ0cn
OgogCWNhc2UgJ2cnOgotCQlyZXQgPDw9IDEwOworCQlyZXQgPDw9IDMwOwogCWNhc2UgJ00nOgog
CWNhc2UgJ20nOgotCQlyZXQgPDw9IDEwOworCQlyZXQgPDw9IDIwOwogCWNhc2UgJ0snOgogCWNh
c2UgJ2snOgogCQlyZXQgPDw9IDEwOwo=
------=_Part_4421_14431686.1121448657857--
