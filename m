Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTD1R63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTD1R63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:58:29 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:21388 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261235AbTD1R62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:58:28 -0400
Date: Mon, 28 Apr 2003 14:10:43 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [TRIVIAL PATCH] sync_dquots_dev in Linux 2.4.21-pre7-ac1
In-Reply-To: <20030416122856.GA21806@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.55.0304281406150.1290@marabou.research.att.com>
References: <Pine.LNX.4.53.0304151217310.28540@marabou.research.att.com>
 <20030416122856.GA21806@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1079419946-1051553443=:1290"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1079419946-1051553443=:1290
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 16 Apr 2003, Jan Kara wrote:

> > sync_dquots_dev() is only implemented if CONFIG_QUOTA is defined.
> > However, quote.c uses it unconditionally.  include/linux/quotaops.h has
> > some macros to disable some functions when CONFIG_QUOTA is undefined, so
> > it's probably where the fix belongs.  This patch helps:
[snip]
> > +#define sync_dquots_dev(dev, type)		do { } while(0)

My patch was misapplied.  Patch against 2.4.21-rc1-ac2 is attached.

And by the way, Linux 2.4.21-rc1-ac2 calls itself 2.4.21-rc1-ac1.

-- 
Regards,
Pavel Roskin
--8323328-1079419946-1051553443=:1290
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dquots.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0304281410430.1290@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="dquots.diff"

LS0tIGxpbnV4Lm9yaWcvaW5jbHVkZS9saW51eC9xdW90YW9wcy5oDQorKysg
bGludXgvaW5jbHVkZS9saW51eC9xdW90YW9wcy5oDQpAQCAtMTkzLDcgKzE5
Myw3IEBADQogI2RlZmluZSBEUVVPVF9TWU5DX1NCKHNiKQkJCWRvIHsgfSB3
aGlsZSgwKQ0KICNkZWZpbmUgRFFVT1RfT0ZGKHNiKQkJCQlkbyB7IH0gd2hp
bGUoMCkNCiAjZGVmaW5lIERRVU9UX1RSQU5TRkVSKGlub2RlLCBpYXR0cikJ
CSgwKQ0KLSNkZWZpbmUgc3luY19kcXVvdGVzX2RldihkZXYsIHR5cGUpCQlk
byAgeyB9IHdoaWxlKDApDQorI2RlZmluZSBzeW5jX2RxdW90c19kZXYoZGV2
LCB0eXBlKQkJZG8geyB9IHdoaWxlKDApDQogZXh0ZXJuIF9faW5saW5lX18g
aW50IERRVU9UX1BSRUFMTE9DX1NQQUNFX05PRElSVFkoc3RydWN0IGlub2Rl
ICppbm9kZSwgcXNpemVfdCBucikNCiB7DQogCWxvY2tfa2VybmVsKCk7DQo=

--8323328-1079419946-1051553443=:1290--
