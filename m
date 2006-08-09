Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWHIMrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHIMrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWHIMrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:47:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:51933 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750724AbWHIMrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:47:18 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 09 Aug 2006 14:40:31 +0200
References: <6EIOG-2xY-31@gated-at.bofh.it> <6EIOG-2xY-33@gated-at.bofh.it> <6EIOG-2xY-35@gated-at.bofh.it> <6EIOG-2xY-37@gated-at.bofh.it> <6EIOG-2xY-39@gated-at.bofh.it> <6EIOG-2xY-19@gated-at.bofh.it> <6Gf5M-2zt-23@gated-at.bofh.it> <6Gfpt-30C-49@gated-at.bofh.it> <6GhAA-6bP-19@gated-at.bofh.it> <6Gx2C-436-5@gated-at.bofh.it> <6HhoT-5E7-33@gated-at.bofh.it> <6HhRQ-6uk-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GAnMi-0000iG-DH@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> Odd.  I wonder if I'm missing a serializing instruction somewhere,
> to ensure the effects of ``self modifying code'' aren't a problem.
> As I read Intels Documentation if you have a jump before you get
> to the code there shouldn't be a problem.

ACK, a short jump to the next instruction *should* be all it takes, but if
it doesn't, maybe a long jump will do the trick.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
