Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbSJDVif>; Fri, 4 Oct 2002 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbSJDVif>; Fri, 4 Oct 2002 17:38:35 -0400
Received: from gw.openss7.com ([142.179.199.224]:21779 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S262085AbSJDVic>;
	Fri, 4 Oct 2002 17:38:32 -0400
Date: Fri, 4 Oct 2002 15:44:05 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004154405.A9439@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk> <20021004.140629.89147658.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004.140629.89147658.davem@redhat.com>; from davem@redhat.com on Fri, Oct 04, 2002 at 02:06:29PM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

How many other architecture-specific exported symbols are there?

It appears to me that many of the system calls themselves are
architecture-specific, particularly so where 64-bit machines
are involved.  Is that a reason to not make them accessible?

--brian

On Fri, 04 Oct 2002, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 03 Oct 2002 23:02:40 +0100
>    
>    Overwriting syscall table entries is not safe. Its not safe because
>    there is no locking mechanism, and its not safe because of the pentium
>    III errata.
> 
> It is also non-portable, such syscall overwriting requires knowledge
> of the layout of the table on every architecture.  On some platforms
> it is a list of pointers + argument count, on some 64-bit platforms
> it is a list of 32-bit truncated pointers to save space.
> 
> There is simply no portable way to make changes to the system call
> table, so exporting it makes zero sense.

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
