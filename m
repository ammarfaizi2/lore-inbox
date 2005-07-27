Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVG0Xzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVG0Xzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVG0Xxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:53:39 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:30089 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261177AbVG0XxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:53:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=cRQWF/nDAOCMo+hQJFFv6wbhSXIfPE6YQZ60n3NDY2gLMs83mYrkytvyYkEYgMXPB4a8sXFX4+S1zH6LfudzZu5uJLbTXeTJHqfutohWJOcN5ITsxRlbokNiUE0AV/pfq5kBHcd4NpcWwzw1wuGyRT3+JvPivDrptCX62tk3Et8=
Message-ID: <4af2d03a050727165319181a40@mail.gmail.com>
Date: Thu, 28 Jul 2005 01:53:21 +0200
From: Jiri Slaby <jirislaby@gmail.com>
Reply-To: Jiri Slaby <jirislaby@gmail.com>
To: Jiri Slaby <xslaby@fi.muni.cz>
Subject: Re: [PATCH] pci_find_device --> pci_get_device [only marks deprecation]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507280135020.27145@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14497_13502345.1122508401336"
References: <Pine.LNX.4.61.0507280135020.27145@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14497_13502345.1122508401336
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 7/28/05, Jiri Slaby <xslaby@fi.muni.cz> wrote:
> On 7/19/05, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Jiri Slaby wrote:
> > >* Marks the function as deprecated in pci.h
> [it is meant pci_find_device]
> >
> > This is a very good idea in my eyes.
>=20
> 2.6.13-rc3-mm2
>=20
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -754,7 +754,7 @@ void pci_setup_cardbus(struct pci_bus *b
>=20
>   /* Generic PCI functions exported to card drivers */
>=20
> -struct pci_dev *pci_find_device (unsigned int vendor, unsigned int devic=
e, const struct pci_dev *from);
> +struct pci_dev *pci_find_device (unsigned int vendor, unsigned int devic=
e, const struct pci_dev *from) __deprecated;
>   struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned =
int device, const struct pci_dev *from);
>   struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
>   int pci_find_capability (struct pci_dev *dev, int cap);

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

There are some additional spaces in the text patch, so repost with an
attachement.

------=_Part_14497_13502345.1122508401336
Content-Type: application/octet-stream; name="lnx-pci_find-depr-6.13r3m2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lnx-pci_find-depr-6.13r3m2.patch"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNpLmggYi9pbmNsdWRlL2xpbnV4L3BjaS5oCi0t
LSBhL2luY2x1ZGUvbGludXgvcGNpLmgKKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtNzU0
LDcgKzc1NCw3IEBAIHZvaWQgcGNpX3NldHVwX2NhcmRidXMoc3RydWN0IHBjaV9idXMgKmIKIAog
LyogR2VuZXJpYyBQQ0kgZnVuY3Rpb25zIGV4cG9ydGVkIHRvIGNhcmQgZHJpdmVycyAqLwogCi1z
dHJ1Y3QgcGNpX2RldiAqcGNpX2ZpbmRfZGV2aWNlICh1bnNpZ25lZCBpbnQgdmVuZG9yLCB1bnNp
Z25lZCBpbnQgZGV2aWNlLCBjb25zdCBzdHJ1Y3QgcGNpX2RldiAqZnJvbSk7CitzdHJ1Y3QgcGNp
X2RldiAqcGNpX2ZpbmRfZGV2aWNlICh1bnNpZ25lZCBpbnQgdmVuZG9yLCB1bnNpZ25lZCBpbnQg
ZGV2aWNlLCBjb25zdCBzdHJ1Y3QgcGNpX2RldiAqZnJvbSkgX19kZXByZWNhdGVkOwogc3RydWN0
IHBjaV9kZXYgKnBjaV9maW5kX2RldmljZV9yZXZlcnNlICh1bnNpZ25lZCBpbnQgdmVuZG9yLCB1
bnNpZ25lZCBpbnQgZGV2aWNlLCBjb25zdCBzdHJ1Y3QgcGNpX2RldiAqZnJvbSk7CiBzdHJ1Y3Qg
cGNpX2RldiAqcGNpX2ZpbmRfc2xvdCAodW5zaWduZWQgaW50IGJ1cywgdW5zaWduZWQgaW50IGRl
dmZuKTsKIGludCBwY2lfZmluZF9jYXBhYmlsaXR5IChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQg
Y2FwKTsK
------=_Part_14497_13502345.1122508401336--
