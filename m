Return-Path: <linux-kernel-owner+w=401wt.eu-S933209AbWLaUTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209AbWLaUTB (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933210AbWLaUTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:19:00 -0500
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:29893 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933209AbWLaUTA convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:19:00 -0500
X-Greylist: delayed 1010 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 15:18:59 EST
Date: Sun, 31 Dec 2006 20:02:05 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: David Brown <dmlb2000@gmail.com>
Cc: Robin Cook <rcook@wyrms.net>, Linux-kernel@vger.kernel.org
Subject: Re: compile failure on 2.6.19
Message-ID: <20061231200205.GA9055@deepthought>
References: <1167585932.3730.9.camel@localhost> <9c21eeae0612311027p17737cc0q765aca18fe22fd38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9c21eeae0612311027p17737cc0q765aca18fe22fd38@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 10:27:26AM -0800, David Brown wrote:
> On 12/31/06, Robin Cook <rcook@wyrms.net> wrote:
> >I am getting this error when I try to compile 2.6.19 and 2.6.19.1.
> >
> >I ran make mrproper and make menuconfig then ran make and got the below
> >error.
> >
> >  HOSTLD  scripts/kconfig/conf
> >scripts/kconfig/conf -s arch/i386/Kconfig
> >  CHK     include/linux/version.h
> >  UPD     include/linux/version.h
> >/bin/sh: -c: line 0: syntax error near unexpected token `('
> >/bin/sh: -c: line 0: `set -e; echo '  CHK
> >include/linux/utsrelease.h'; mkdir -p include/linux/;     if [ `echo -n
> >"2.6.19.1 .file null .ident
> >GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ];
> >then echo '"2.6.19.1 .file null .ident
> >GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" exceeds 64
> >characters' >&2; exit 1; fi; (echo \#define UTS_RELEASE \"2.6.19.1 .file
> >null .ident GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits\";) <
> >include/config/kernel.release > include/linux/utsrelease.h.tmp; if [ -r
> >include/linux/utsrelease.h ] && cmp -s include/linux/utsrelease.h
> >include/linux/utsrelease.h.tmp; then rm -f
> >include/linux/utsrelease.h.tmp; else echo '  UPD
> >include/linux/utsrelease.h'; mv -f include/linux/utsrelease.h.tmp
> >include/linux/utsrelease.h; fi'
> >make: *** [include/linux/utsrelease.h] Error 2
> 
> I'd check /dev/null and make sure it's not a regular file this
> happened to me a while back
> 
> - David Brown

 If that doesn't fix it, I suspect it's a shell problem (e.g.
bash-3.{1,2} without all the patches).  I've seen a number of
issues with bash in the past few months, sometimes it highlighted
code that needed to be fixed, other times it tripped over
parentheses.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
