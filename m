Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319345AbSHQFCJ>; Sat, 17 Aug 2002 01:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319350AbSHQFCJ>; Sat, 17 Aug 2002 01:02:09 -0400
Received: from smtp1.arnet.com.ar ([200.45.191.6]:54546 "HELO
	smtp1.arnet.com.ar") by vger.kernel.org with SMTP
	id <S319345AbSHQFCI>; Sat, 17 Aug 2002 01:02:08 -0400
Date: Sat, 17 Aug 2002 02:06:14 -0300
From: John Coppens <jcoppens@usa.net>
To: Samuel Flory <sflory@rackable.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: proc/sys/fs file-nr?
Message-Id: <20020817020614.7689dec9.jcoppens@usa.net>
In-Reply-To: <1029536548.6469.185.camel@flory.corp.rackablelabs.com>
References: <20020816183312.728a970a.jcoppens@usa.net>
	<1029536548.6469.185.camel@flory.corp.rackablelabs.com>
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2002 15:22:27 -0700
Samuel Flory <sflory@rackable.com> wrote:

> 
> Check inode-nr in addition to file-max.  What is your ulimit set to.  I
> think the default is 1024.
> 
core file size (blocks)     0
data seg size (kbytes)      unlimited
file size (blocks)          unlimited
max locked memory (kbytes)  unlimited
max memory size (kbytes)    unlimited
open files                  1024
pipe size (512 bytes)       8
stack size (kbytes)         8192
cpu time (seconds)          unlimited
max user processes          2047
virtual memory (kbytes)     unlimited

Ok. I suppose open files is the limit, but the problem appears much before that.
Anyway, I tried to change with ulimit -n 2048, but the gThumb still gives up.
(there are only 900 images in the directory, and the program gives up at maybe
600).

The numbers in /proc/sys/fs/file-nr change with a rate of about 3 - 4 each
thumbnail that is opened.

John
