Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUJLVfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUJLVfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUJLVfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:35:55 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:23784 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S267851AbUJLVfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:35:24 -0400
Message-ID: <416C4E15.9000503@t-online.de>
Date: Tue, 12 Oct 2004 23:35:17 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
References: <1097446129l.5815l.0l@werewolf.able.es> <20041012001901.GA23831@kroah.com> <416B91C4.7050905@t-online.de> <20041012165809.GA11635@kroah.com> <416C26B4.6040408@t-online.de> <20041012185733.GA31222@kroah.com> <416C3BB6.4040200@t-online.de> <20041012203022.GB32139@kroah.com>
In-Reply-To: <20041012203022.GB32139@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Zqs2-oZaZehILSxBregYDZG5+xbVdtgyLn1NSnQvsru5CRnm0Og8gZ
X-TOI-MSGID: 8d92d4aa-e489-4f24-9d3b-57dd90e8b225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Oct 12, 2004 at 10:16:54PM +0200, Harald Dunkel wrote:
> 
>>Greg KH wrote:
>>
>>>Yeah, the documentation is out there, somewhere...
>>>
>>
>>What I really do not like for initramfs is that the
>>cpio file is compiled into the kernel. Extremely
>>unflexible. Why should I use modules then?
>>
>>Is it possible to load the initramfs like an initrd
>>on the grub command line?
> 
> 
> Why post this in private?
> 
> Care to ask this on the linux-kernel mailing list and CC me?  That way I
> can answer it in public to enable everyone else to know the answer, and
> let the search engines pick it up.
> 
> thanks,
> 
> greg k-h
> 
Sorry, somewhere in this thread I had clicked the wrong
reply button.

Talking about initramfs: I am still trying to become
familiar with this stuff. I have found a lot of small
pieces of information (still reading), and the cpio
stuff in the kernel usr directory. But I have 2 questions:

Why is the initramfs built at the beginning of the
kernel build procedure? Wouldn't it be more reasonable
to build it when all kernel modules are available?

And why is it compiled into the kernel at all? The
README in Documentation/early-userspace says

<quote>
"Early userspace" is a set of libraries and programs that provide
various pieces of functionality that are important enough to be
available while a Linux kernel is coming up, but that don't need to be
run inside the kernel itself.
</quote>

So why compile it into the kernel? IMHO it would be more
flexible to load the early-userspace stuff similar to initrd
via the grub command line. Compiling it into the kernel
could be optional.


Regards

Harri
