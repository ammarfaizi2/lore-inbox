Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGPNJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGPNJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVGPNJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:09:35 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:10861 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261576AbVGPNJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:09:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=PtenEuIuKcMfihI8k5n8NxggTWVQTJd7XF5aV0zGqDWAcb45ZUqqMFRP1pkqx553lGdDVUK33Ro2+KAGBEPTc2JZseBSKB+FL3oeGd9k2q//HWhddMpg+N8WLtPOeusqJIazmJ/5QV1AgQQuJWkzDrEcEMbeSgafVBDUlrt95k8=
Message-ID: <9e4733910507160609472f729c@mail.gmail.com>
Date: Sat, 16 Jul 2005 09:09:32 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: PATCH: Adjust PCI rom code to handle more broken ROMs
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15462_1742794.1121519372824"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_15462_1742794.1121519372824
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

There are ROMs reporting that their size exceeds their PCI ROM
resource window. This patch returns the minimum of the resource window
size or the size in the ROM.  An example of this breakage is the XGI
Volari Z7.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Patch is in an attachment since gmail will mangle the tabs.

--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_15462_1742794.1121519372824
Content-Type: text/x-patch; name="broken_rom.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="broken_rom.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3JvbS5jIGIvZHJpdmVycy9wY2kvcm9tLmMKLS0tIGEv
ZHJpdmVycy9wY2kvcm9tLmMKKysrIGIvZHJpdmVycy9wY2kvcm9tLmMKQEAgLTEyNSw3ICsxMjUs
OSBAQCB2b2lkIF9faW9tZW0gKnBjaV9tYXBfcm9tKHN0cnVjdCBwY2lfZGV2CiAJCWltYWdlICs9
IHJlYWR3KHBkcyArIDE2KSAqIDUxMjsKIAl9IHdoaWxlICghbGFzdF9pbWFnZSk7CiAKLQkqc2l6
ZSA9IGltYWdlIC0gcm9tOworCS8qIG5ldmVyIHJldHVybiBhIHNpemUgbGFyZ2VyIHRoYW4gdGhl
IFBDSSByZXNvdXJjZSB3aW5kb3cgKi8KKwkvKiB0aGVyZSBhcmUga25vd24gUk9NcyB0aGF0IGdl
dCB0aGUgc2l6ZSB3cm9uZyAqLworCSpzaXplID0gbWluKChzaXplX3QpKGltYWdlIC0gcm9tKSwg
KnNpemUpOwogCiAJcmV0dXJuIHJvbTsKIH0K
------=_Part_15462_1742794.1121519372824--
