Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRHTS7e>; Mon, 20 Aug 2001 14:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268842AbRHTS7Y>; Mon, 20 Aug 2001 14:59:24 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:21172 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268833AbRHTS7K>; Mon, 20 Aug 2001 14:59:10 -0400
Date: Mon, 20 Aug 2001 13:59:13 -0500
From: Dave McCracken <dmc@austin.ibm.com>
To: george anzinger <george@mvista.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in/proc/<pid>/status
Message-ID: <23580000.998333953@baldur>
In-Reply-To: <3B815BFD.80D62209@mvista.com>
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu>
 <26210000.998324773@baldur> <3B815BFD.80D62209@mvista.com>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 20, 2001 11:50:37 -0700 george anzinger 
<george@mvista.com> wrote:

> Are you possibly also looking into allocating a small data structure to
> the thread group?  A place to keep thread group signal info, perhaps?

No, not specifically.  A mechanism already exists to share info between 
cooperating tasks, where there's a common structure pointed to by each task 
(ie mm_struct, signal_struct, files_struct, fs_struct, etc).  I think we 
can use this mechanism for any info a group of tasks needs to share.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmc@austin.ibm.com                                      T/L   678-3059

