Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWG0Ru6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWG0Ru6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWG0Ru6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:50:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:48119 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750980AbWG0Ru5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:50:57 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Require mmap handler for a.out executables
To: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
Reply-To: 7eggert@gmx.de
Date: Thu, 27 Jul 2006 19:49:42 +0200
References: <6COYh-8f0-41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G69zn-0001Wb-66@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote:

> with the nasty /proc privilege escalation (CVE-2006-3626) it became
> clear that we need to do something more to better protect us against
> people exploiting stuff in /proc. Besides the don't allow chmod stuff,
> Eugene also proposed to depend the a.out execution on the existence of
> the mmap handler. Since we are doing the same for ELF, this makes
> totally sense to me.

Can shell scripts or binfmt_misc be exploited, too? Even if not, I'd
additionally force noexec, nosuid on proc and sysfs mounts.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
