Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSH0NTi>; Tue, 27 Aug 2002 09:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSH0NTi>; Tue, 27 Aug 2002 09:19:38 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:17059 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315925AbSH0NTh>; Tue, 27 Aug 2002 09:19:37 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 27 Aug 2002 06:23:48 -0700
Message-Id: <200208271323.GAA04833@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: Loop devices under NTFS
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Aug 27, 2002 at 05:40:52AM -0700, Adam J. Richter wrote:
>> 	There are only a few file systems that provide writable files
>> without aops->{prepare,commit}_write.  I think they are just tmpfs,
>> ntfs and intermezzo.  If all file systems that provided writable files
>> could be expected to provide {prepare,commit}_write, I could eliminate
>> the file_ops->{read,write} code from loop.c.

>This is the wrong level of abstraction.  There is no reason why a filesystem
>has to use the pagecache at all.

	Are you complaining about something in loop.c, or are you just
saying that you'd like to see some kind of
generic_file_{prepare,commit}_write routines that plain files in all
writable filesystems could use?


>Note that there is a more severe bug in loop.c:  it's abuse of
>do_generic_file_read.  

	Could you please elaborate on this and give an example where
it return incorrect data, deadlock, generate a kernel oops, etc.?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

