Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290822AbSAaBwS>; Wed, 30 Jan 2002 20:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290824AbSAaBwM>; Wed, 30 Jan 2002 20:52:12 -0500
Received: from rj.SGI.COM ([204.94.215.100]:57985 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290822AbSAaBwB>;
	Wed, 30 Jan 2002 20:52:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*... 
In-Reply-To: Your message of "Wed, 30 Jan 2002 20:17:54 CDT."
             <20020130201754.B18730@havoc.gtf.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 12:51:50 +1100
Message-ID: <7417.1012441910@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 20:17:54 -0500, 
Jeff Garzik <garzik@havoc.gtf.org> wrote:
>On Thu, Jan 31, 2002 at 10:33:46AM +1100, Keith Owens wrote:
>> On Wed, 30 Jan 2002 13:24:22 -0500, 
>> Pete Zaitcev <zaitcev@redhat.com> wrote:
>> >Kernel headers are not to be included in applications.
>> 
>> Just to flog this dead horse into the ground, the reverse is also true.
>> Kernel code must not include user space headers (kernel code excludes
>> programs that are used to build the kernel).
>
>Wow, does that actually occur?  File references?

It slips in occasionally.  LVM in 2.4.0-test had #include <endian.h>, I
vaguely remember some compression code that included glibc headers by
mistake.  We weed them out of the kernel whenever we spot them, they
tend not to live very long.  Christoph Hellwig suggested a Makefile
change that prevents kernel code including user space headers, it is
included in kbuild 2.5 and there is a 2.4 version in

http://marc.theaimsgroup.com/?l=linux-kernel&m=100321690511549&w=2

