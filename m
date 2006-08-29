Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965436AbWH2WRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbWH2WRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 18:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbWH2WRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 18:17:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63975 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965436AbWH2WRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 18:17:19 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
To: Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org, David Lang <dlang@digitalinsight.com>
Reply-To: 7eggert@gmx.de
Date: Wed, 30 Aug 2006 00:10:42 +0200
References: <6OXsW-4pW-7@gated-at.bofh.it> <6Peat-82q-17@gated-at.bofh.it> <6PgFh-53l-7@gated-at.bofh.it> <6Ph8l-61I-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GIBnS-0001Xq-KV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mb@bu3sch.de> wrote:

> The ipw needs the firmware on insmod time (in contrast to bcm43xx
> for example, which needs it on ifconfig up time).
> So ipw needs to call request_firmware at insmod time. In case of
> built-in, that is when the initcall happens. No userland is available
> and request_firmware can not call the userspace helpers to upload
> the firmware to sysfs.
> Well, not really easy to find a sane solution for this. :)

Can you trigger loading the firmware from userspace?
echo 1 > /sys/module/iw2200/parameters/load_firmware_now
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
