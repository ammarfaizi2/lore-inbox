Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUL3ELj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUL3ELj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUL3ELg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:11:36 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:1925 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261425AbUL3ELX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:11:23 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=OXYPbbJhPxcifdr3rM3SnOZBlCNhxGkCnFfkX9CFuaZ9gZUhmE1OQllS2cCEIivvL3Bxwe4D6aWvztFjvieVptoVUvMkmJ5KMh5U8auMrZlnmfrTOB2/24CwkQKRf9E2KSC070XrZIFdX7vbG++35flZwlBvmJEHuhLIEgH1qCE=  ;
Message-ID: <20041230041123.10778.qmail@web60606.mail.yahoo.com>
Date: Wed, 29 Dec 2004 20:11:23 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re : Re: System calls effect after booting phase ?? 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412291205.iBTC52RX016345@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank u for the help,
 
     In the kconfig.tk file, under which section
should we add the line CONFIG_FOO. Will u plz
elaborate the process?

Thanks,
selva

--- Valdis.Kletnieks@vt.edu wrote:

> On Wed, 29 Dec 2004 03:25:10 PST, selvakumar
> nagendran said:
> 
> >   Now, I want to store them in a table. But I want
> > this operation to be started right after the
> initial
> > booting phase itself part of the loading kernel
> > itself. What should I do to add my module into the
> > already compiled kernel image just like a standard
> > kernel module?
> 
> Possibility 1:
> Load them from an initrd image while booting.  If
> you're already
> using an initrd, and this is "early enough", you
> just need to put the
> module into the initrd, and make sure the /linuxrc
> or whatever script
> does an insmod for it.  This has the advantage of
> working for out-of-tree
> modules.
> 
> Possibility 2:
> Build them into the kernel.  For in-tree modules,
> this is done with
> a bit of Kconfig/Makefile magic. In the Kconfig
> file, you can define
> a CONFIG_FOO variable, and then in the Makefile, do
> this:
> 
> obj-$(CONFIG_FOO) += foo.o
> 
> So if CONFIG_FOO is set to 'y' (build into kernel),
> it gets
> added to the obj-y target list and then linked in. 
> If it's set to
> 'm' (module) or 'n' (don't build at all), it's added
> to the obj-m or obj-n
> targets, which then aren't linked into the kernel.
> 
> Not sure how you'd go about building an out-of-tree
> module into the kernel,
> or if that's even supposed to be possible...
> 

> ATTACHMENT part 2 application/pgp-signature 




		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

