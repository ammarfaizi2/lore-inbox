Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBASwl>; Thu, 1 Feb 2001 13:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131514AbRBASwb>; Thu, 1 Feb 2001 13:52:31 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:33054 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S131543AbRBASwR>; Thu, 1 Feb 2001 13:52:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.45148.886179.74191@somanetworks.com>
Date: Thu, 1 Feb 2001 13:52:12 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: hiren_mehta@agilent.com
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with devfsd compilation
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "hm" == hiren mehta <hiren_mehta@agilent.com> writes:

 hm> Hi, I am trying to compile devfsd on my system running RedHat
 hm> linux 7.0 (kernel 2.2.16-22). I get the error "RTLD_NEXT"
 hm> undefined. I am not sure where this symbol is defined. Is there
 hm> anything that I am missing on my system.

Oh yeah, here's the two other things I forgot.

The install target of the devfsd GNUmakefile attempts to copy the
devfsd.8 man page into /usr/man/man8 which doesn't exist.  RH7 has
its man pages in /usr/share/man though you might prefer
/usr/local/man, whatever.  I just changed the GNUmakefile.

Also, RH7's /etc/rc.sysinit can already start devfsd automatically
with the following line:

    [ -e /dev/.devfsd -a -x /sbin/devfsd ] && /sbin/devfsd /dev

So, all you have to do is create an empty file /dev/.devfsd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
