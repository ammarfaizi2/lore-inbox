Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbTINUKD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 16:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTINUKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 16:10:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28653 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261298AbTINUJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 16:09:58 -0400
Message-ID: <3F64CB08.9010506@pobox.com>
Date: Sun, 14 Sep 2003 16:09:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: "J.A. Magallon" <jamagallon@able.es>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata update posted
References: <3F628DC7.3040308@pobox.com> <20030913205652.GA3478@werewolf.able.es> <20030913212849.GB21426@gtf.org> <20030914111225.A3371@pclin040.win.tue.nl> <3F64A4BD.6030906@pobox.com> <20030914213821.A11134@pclin040.win.tue.nl>
In-Reply-To: <20030914213821.A11134@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Sun, Sep 14, 2003 at 01:26:21PM -0400, Jeff Garzik wrote:
> 
> 
>>>This shows why defkeymap.c is not generated in the kernel build
>>>but distributed.
>>
>>There is a difference between distributing generated files, and checking 
>>generated files into a repository...  I do not advocate changing the 
>>tarball, just the BK repo behind it.
> 
> 
> So you would like to remove defkeymap.c from the bitkeeper repository.
> Can you briefly explain why?
> I am not a bk user so have no feeling for what one would like bk to do.
> 
> But it seems to me that if defkeymap.c is only a generated file when
> no kbd headers have changed, while in the opposite case one needs a
> private version of loadkeys until the next version of kbd has been
> distributed, it is easier to regard it as part of the kernel source.

defkeymap.c is _always_ a generated file.  However, some environments 
lack the capability to generate it (properly).

My motivation is not bitkeeper-specific:  I dislike the practice of 
checking build-generated files into an SCM of any sort.  That sort of 
stuff should be handled by the maintainer, when generating the release 
patches and tarballs.  aic7xxx is another example

Package developers (read: kernel hackers) are expected to have a correct 
environment to rebuild generated files properly.  Package builders are 
only expected to have a minimal build environment, with stuff like 
configure scripts, yacc/lex output, defkeymap, and similar things 
pre-generated from a canonical source (the maintainer).

The GNOME guys recognized this distinction between hackers and builders 
a long time ago.  When you check things out of GNOME cvs, you get _just_ 
the sources.  One must run ./autogen.sh to generate the 
autoconf/automake/libtool junk needed to actually build successfully.

	Jeff



