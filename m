Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262751AbREONZN>; Tue, 15 May 2001 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262752AbREONZD>; Tue, 15 May 2001 09:25:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2346 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262751AbREONYx>; Tue, 15 May 2001 09:24:53 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: "H . J . Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
        alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <m1k83kj7dj.fsf@frodo.biederman.org> <m1y9s1jbml.fsf@frodo.biederman.org> <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <16874.989832587@redhat.com> <8717.989859079@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 May 2001 07:21:59 -0600
In-Reply-To: David Woodhouse's message of "Mon, 14 May 2001 17:51:19 +0100"
Message-ID: <m1eltqkars.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> ebiederm@xmission.com said:
> >  There wasn't even DHCP support before so yes you did.   As you can't
> > get the nfs mount point from bootp. 
> 
> Wasn't there a default? The Indy behind me seems to try to mount
> /tftpboot/172.16.18.195, so I put a filesystem there just to make it happy.
> 
> It's a 2.4.3 kernel.

Duh.  I forgot about the default path.

> >  Well I think in the CONFIG_BLK_DEV=n case it might wind up being a
> > ramfs or tmpfs image.  Something like a simplified version of tar. 
> 
> Well, if it stops working and stays broken, I suppose I'll just have to 
> hack up a built-in command line option. ISTR ARM already has such an option.
> 
> I'd rather it didn't break, though.

The clean way to handle it, and I'll take a look it to have
root=/dev/nfs (and the rdev equivalent) to set ip=on if it isn't
already.  The current 2.4.4 behavior of root=/dev/hda3 doing ip
autoconfig when the code is compiled into the kernel is just bad.

Eric
