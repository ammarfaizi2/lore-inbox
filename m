Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263344AbVFYFsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbVFYFsH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 01:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbVFYFsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 01:48:06 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:50668 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263344AbVFYFsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 01:48:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kJmprrVQT9+RCys0rkI6CTS+r28a8Ao0lebJXwMjo7/cnmI11nZk0bTLOLN4ct+ao8C5LwIRBZTyRI+pYgKzcwWUtXAyg2r8DiFrY3C6LAQ8FlkPvMO0ttuMHLzScuu0qRTh+A7FwG5tr1XBKT1srm9JP93uAF4ns8ho4NxheM4=
Message-ID: <105c793f050624224872c46b38@mail.gmail.com>
Date: Sat, 25 Jun 2005 01:48:02 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: ncunningham@cyclades.com
Subject: Re: Mismatched suspend2 interfaces == Suspend was aborted
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend2-Users <suspend2-users@lists.suspend2.net>
In-Reply-To: <1119674219.4170.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f05062421207c6ad27@mail.gmail.com>
	 <1119674219.4170.4.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/05, Nigel Cunningham <ncunningham@cyclades.com> wrote:
> Assuming you compiled LZF cryptoapi support in and want to use it, the
> right thing to do is edit your hibernate.conf (probably in
> /etc/hibernate) and add the lines:
> 
> ProcSetting compressor lzf
> ProcSetting disable_encryption 1
I saw the note about this on suspend2.net but, for whatever reason,
read it as "add this to your hibernate script." So I incorrectly added
the above lines to /usr/local/sbin/hibernate. Durrr.

> If you haven't compiled lzf in, you'll need to include the module in an
> initrd/initramfs and load it before doing echo >
> /proc/software_suspend/do_resume in the script, so compiling in is the
> simpler option.
I think I had compiled lzh as a module so this was also causing
problems. Since I compiled lzh (and some of the others that looked
like fun) into the kernel and added the above lines to
/etc/hibernate/hibernate.conf, hibernation seems to be working better.
I'll have to play with it some more so it breaks.

> Hope this helps.
Unfortunately, it did.

Thanks.

-Andy
