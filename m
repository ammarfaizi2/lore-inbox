Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbSJDNFf>; Fri, 4 Oct 2002 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJDNFf>; Fri, 4 Oct 2002 09:05:35 -0400
Received: from gw.openss7.com ([142.179.199.224]:28430 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261601AbSJDNFe>;
	Fri, 4 Oct 2002 09:05:34 -0400
Date: Fri, 4 Oct 2002 07:11:06 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004071106.A18191@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20021003170608.A30759@openss7.org.suse.lists.linux.kernel> <1033722612.1853.1.camel@localhost.localdomain.suse.lists.linux.kernel> <20021004051932.A13743@openss7.org.suse.lists.linux.kernel> <p73k7kyqrx6.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73k7kyqrx6.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Oct 04, 2002 at 03:01:25PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, 04 Oct 2002, Andi Kleen wrote:

> "Brian F. G. Bidulock" <bidulock@openss7.org> writes:
> 
> 
> > 					   void *dataptr, int band, int flags)
> > 	{
> > 		int ret =3D -ENOSYS;
> > 		read_lock(&streams_call_lock);
> 
> I don't think you really want to use any spinlocks this way. They would
> make sleeping impossible and you could never legally do a copy_from/to_user
> in your system call. And how else would you access dataptr ? 
> 
> More likely you want an atomic_inc(&modulecounter) or perhaps a rw
> semaphore.

read_lock and write_lock are a rw semaphores, aren't they?

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
