Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSJDF0x>; Fri, 4 Oct 2002 01:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSJDF0x>; Fri, 4 Oct 2002 01:26:53 -0400
Received: from gw.openss7.com ([142.179.199.224]:14605 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261312AbSJDF0u>;
	Fri, 4 Oct 2002 01:26:50 -0400
Date: Thu, 3 Oct 2002 23:32:21 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021003233221.C31444@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de> <20021003235022.GA82187@compsoc.man.ac.uk> <mailman.1033691043.6446.linux-kernel2news@redhat.com> <200210040403.g9443Vu03329@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210040403.g9443Vu03329@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, Oct 04, 2002 at 12:03:31AM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,

On Fri, 04 Oct 2002, Pete Zaitcev wrote:
> 
> Also, if you are a provider of a binary-only crapware which wants
> to override syscalls, there's one very important document for
> you to see: it's called Fig.1.
> 
> GPLed code has no problem linking with sys_call_table.
> 

The code in question (LiS) is LGPL and open source.  The iBCS
packge is GPL and open source.

You do know that there *is* open source code which is not
contained in the Linux kernel ;)

So, in this case, GPL and LGPL modules do have a problem linking
with the sys_call_table (on RH 8.0 and I suppose some
development kernels only), because the symbol is no longer
exported and no registration procedure was provided for
registering otherwise non-implemented system calls (in
particular the UNIX98 and iBCS/ABI standard putmsg/getmsg
calls).

And what about AFS?  I see that it uses a sys_ni_syscall slot as
well...

In fact all these components are opensource.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
