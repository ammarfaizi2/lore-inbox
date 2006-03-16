Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWCPTk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWCPTk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCPTk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:40:58 -0500
Received: from mail.gmx.de ([213.165.64.20]:25550 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750940AbWCPTk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:40:57 -0500
Date: Thu, 16 Mar 2006 20:40:55 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de,
       paulus@samba.org, janak@us.ibm.com
MIME-Version: 1.0
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
Subject: =?ISO-8859-1?Q?Re:_[PATCH]_unshare:_Cleanup_up_the_sys=5Funshare_interfac?=
 =?ISO-8859-1?Q?e_before_we_are_committed.?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <31641.1142538055@www064.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

> Since we have not crossed the magic 2.6.16 line can we please
> include this patch.  My apologies for catching this so late in the
> cycle.
> 
> - Error if we are passed any flags we don't expect.
> 
>   This preserves forward compatibility so programs that use new flags 
>   that
>   run on old kernels will fail instead of silently doing the wrong thing.
> 
> - Use separate defines from sys_clone.
> 
>   sys_unshare can't implement half of the clone flags under any
> circumstances
>   and those that it does implement have subtlely different semantics than
>   the clone flags.  Using a different set of flags sets the
>   expectation that things will be different.
> 
>   Binary compatibility with current users of the is still maintained
>   as the unshare flags and the clone flags have the same values.

Thanks for this.  I had begun to think I must simply be dense
for thinking there was a problem here...

I will update my draft manual page accordingly.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
