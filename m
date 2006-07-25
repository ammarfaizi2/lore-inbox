Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWGYXPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWGYXPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWGYXPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:15:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:57802 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030246AbWGYXPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:15:08 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually find a device
To: Jesper Juhl <jesper.juhl@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Andrew Morton <akpm@osdl.org>, Mike Miller <mike.miller@hp.com>,
       iss_storagedev@hp.com, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 26 Jul 2006 01:14:23 +0200
References: <6CDJo-8vC-31@gated-at.bofh.it> <6CDSZ-h7-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G5W6u-000133-Lo@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

>> If we don't find any devices, we shouldn't print anything.
>>
> I disagree.
> I find it quite nice to be able to see that the driver loaded even if
> it finds nothing. At least then when there's a problem, I can quickly
> see that at least it is not because I didn't forget to load the
> driver, it's something else. Saves time since I can start looking for
> reasons why the driver didn't find anything without first spending
> additional time checking if I failed to cause it to load for some
> reason.

I disagree differently: the driver version is a function of the kernel
version, and the load status can easily be obtained. Therefore I suggest
never printing the version number from in-kernel drivers.

Maybe adding a debug kernel parameter that will cause module loads to be more
verbose for all modules is more reasonable.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
