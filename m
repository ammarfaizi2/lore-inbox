Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUIMXfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUIMXfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUIMXfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:35:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:12708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268998AbUIMXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:35:06 -0400
Date: Mon, 13 Sep 2004 16:34:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: kronos@kronoz.cjb.net, linux-kernel <linux-kernel@vger.kernel.org>,
       joq@io.com, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040913163448.T1973@build.pdx.osdl.net>
References: <20040912155035.GA17972@dreamland.darkstar.lan> <1095117752.1360.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1095117752.1360.5.camel@krustophenia.net>; from rlrevell@joe-job.com on Mon, Sep 13, 2004 at 07:22:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> +Once the LSM has been installed and the kernel for which it was built
> +is running, the root user can load it and pass parameters as follows:
> +
> +  # modprobe realtime any=1
> +
> +  Any program can request realtime privileges.  This allows any local
> +  user to crash the system by hogging the CPU in a tight loop or
> +  locking down too much memory.  But, it is simple to administer.  :-)
> +
> +  # modprobe realtime gid=29
> +
> +  All users belonging to group 29 and programs that are setgid to that
> +  group have realtime privileges.  Use any group number you like.
> +
> +  # modprobe realtime mlock=0
> +
> +  Grants realtime scheduling privileges without the ability to lock
> +  memory using mlock() or mlockall() system calls.  This option can be
> +  used in conjunction with any of the other options.
> +
> +  # modprobe realtime allcaps=1
> +
> +  Enables all capabilities, including CAP_SETPCAP.  This is equivalent
> +  to the 2.4 kernel capabilities patch.  It is needed for root
> +  programs to assign realtime capabilities to other processes.  This
> +  option can be used in conjunction with any of the other options.

The mlock() bit is unecessary now.  Use rlimits on the audio users.
Which leaves realtime bits, plus others.  I had a more generic module
(per-capability) that would be a superset of this.  Perhaps that's a
better fit.  I'm travelling this week, so forgive the spotty replies.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
