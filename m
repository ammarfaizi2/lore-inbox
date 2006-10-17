Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWJQXNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWJQXNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWJQXNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:13:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:48580 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751066AbWJQXND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:13:03 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
To: Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       Ismail Donmez <ismail@pardus.org.tr>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
Reply-To: 7eggert@gmx.de
Date: Wed, 18 Oct 2006 01:09:37 +0200
References: <771eN-VK-9@gated-at.bofh.it> <771yn-1XU-65@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GZy4L-00015O-AV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti <kronos.it@gmail.com> wrote:

> +++ b/fs/isofs/rock.c

> +
> +                     /* Rock Ridge V1.12, override inode number */
> +                     if (rr->len == 44)
> +                             inode->i_ino = isonum_733(rr->u.PX.inode);

I think it's wrong again, it will break as soon as rockridge 1.13 defines
an additional field. s,==,>=, should do the trick.

BTW and without digging in the code: Since version 2 will be binary
incompatible, is there a version check?

BTW2, Just to be cautionous: what will happen if somebody forces the same
inode number on two different entries?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
