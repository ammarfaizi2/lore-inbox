Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbTE1PrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTE1PrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:47:07 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:31455 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264775AbTE1PrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:47:05 -0400
Date: Wed, 28 May 2003 12:00:20 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@infradead.org>
cc: devfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Graceful failure in devfs_remove() in 2.5.x
In-Reply-To: <20030528104603.A27503@infradead.org>
Message-ID: <Pine.LNX.4.55.0305281143410.1556@marabou.research.att.com>
References: <Pine.LNX.4.55.0305271105110.1412@marabou.research.att.com>
 <20030528104603.A27503@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-869121793-1054137620=:1702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-869121793-1054137620=:1702
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 28 May 2003, Christoph Hellwig wrote:

> On Tue, May 27, 2003 at 11:29:53AM -0400, Pavel Roskin wrote:
> > This patch makes devfs_remove() print an error to the kernel log and
> > continue.  PRINTK is defined in fs/devfs/base.c to report errors in the
> > cases like this one:
>
> Patch looks okay _except_ for use of this gross macro.  Just
> ise plain printk instead.

I always try to follow the existing code style, but if you want me to make
an exception, here it is.  Fixed patch is attached.

-- 
Regards,
Pavel Roskin
--8323328-869121793-1054137620=:1702
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="devfs-rm.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0305281200200.1702@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="devfs-rm.diff"

LS0tIGxpbnV4Lm9yaWcvZnMvZGV2ZnMvYmFzZS5jDQorKysgbGludXgvZnMv
ZGV2ZnMvYmFzZS5jDQpAQCAtMTcxMCw2ICsxNzEwLDEyIEBAIHZvaWQgZGV2
ZnNfcmVtb3ZlKGNvbnN0IGNoYXIgKmZtdCwgLi4uKQ0KIAlpZiAobiA8IDY0
ICYmIGJ1ZlswXSkgew0KIAkJZGV2ZnNfaGFuZGxlX3QgZGUgPSBfZGV2ZnNf
ZmluZF9lbnRyeShOVUxMLCBidWYsIDApOw0KIA0KKwkJaWYgKCFkZSkgew0K
KwkJCXByaW50ayhLRVJOX0VSUiAiJXM6ICVzIG5vdCBmb3VuZCwgY2Fubm90
IHJlbW92ZVxuIiwNCisJCQkgICAgICAgX19GVU5DVElPTl9fLCBidWYpOw0K
KwkJCXJldHVybjsNCisJCX0NCisNCiAJCXdyaXRlX2xvY2soJmRlLT5wYXJl
bnQtPnUuZGlyLmxvY2spOw0KIAkJX2RldmZzX3VucmVnaXN0ZXIoZGUtPnBh
cmVudCwgZGUpOw0KIAkJZGV2ZnNfcHV0KGRlKTsNCg==

--8323328-869121793-1054137620=:1702--
