Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTEZXjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTEZXjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:39:13 -0400
Received: from imap.gmx.net ([213.165.65.60]:33866 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262358AbTEZXjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:39:11 -0400
Message-ID: <3ED2A8B2.5040607@gmx.net>
Date: Tue, 27 May 2003 01:52:18 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Gregoire Favre <greg@magma.unil.ch>
CC: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xfs don't compil in linux-2.5 BK
References: <20030526193136.GB10276@magma.unil.ch> <1053986469.3754.6.camel@nalesnik.localhost> <20030526223803.GB14954@magma.unil.ch>
In-Reply-To: <20030526223803.GB14954@magma.unil.ch>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregoire Favre wrote:
> On Mon, May 26, 2003 at 11:01:12PM +0100, Grzegorz Jaskiewicz wrote:
> 
> 
>>looks like LINUX_VERSION_CODE is not defined
>>try this (as 2.5.69 > than 2.5.9)
> 
> 
> Well, maybe BK is not for me:
> 
> greg@greg:linux >make dep && make bzImage && make modules && sudo make modules_install
> *** Warning: make dep is unnecessary now.
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
>   CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>   CC      fs/xfs/pagebuf/page_buf.o
> In file included from fs/xfs/pagebuf/page_buf.c:65:
> fs/xfs/pagebuf/page_buf_internal.h:46:24: operator '<' has no left operand
> fs/xfs/pagebuf/page_buf_internal.h:51:24: operator '<' has no left operand
> make[2]: *** [fs/xfs/pagebuf/page_buf.o] Error 1
> make[1]: *** [fs/xfs] Error 2
> make: *** [fs] Error 2
> Exit 2

if you are using bk, maybe not all files were checked out? Try

bk -r get

and if the error still does not go away,

make mrproper

and then

make {,x,menu}config

make dep does nothing in 2.5 and make bzImage is standard target, so you
can abbreviate you command line to

make && make modules && sudo make modules_install


HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/

