Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWEAX34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWEAX34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWEAX34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:29:56 -0400
Received: from smtpout.mac.com ([17.250.248.173]:3308 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932324AbWEAX3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:29:55 -0400
In-Reply-To: <20060501203815.GE19423@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, akpm@osdl.org,
       schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] s390: Hypervisor File System
Date: Mon, 1 May 2006 19:29:23 -0400
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 1, 2006, at 16:38:15, Greg KH wrote:
> On Sun, Apr 30, 2006 at 01:18:46AM -0400, Kyle Moffett wrote:
>> On Apr 29, 2006, at 17:55:01, Greg KH wrote:
>>> relayfs is for that.  You can now put relayfs files in any ram  
>>> based file system (procfs, ramfs, sysfs, debugfs, etc.)
>>
>> But you can't twiddle relayfs with echo and cat; it's more suited  
>> to high-bandwidth transfers than anything else, no?
>
> Yes.

So my question stands:  What is the _recommended_ way to handle  
simple data types in low-bandwidth/frequency multiple-valued  
transactions to hardware?  Examples include reading/modifying  
framebuffer settings (currently done through IOCTLS), s390 current  
state (up for discussion), etc.  In these cases there needs to be an  
atomic snapshot or write of multiple values at the same time.  Given  
the situation it would be _nice_ to use sysfs so the admin can do it  
by hand; makes things shell scriptable and reduces the number of  
binary compatibility issues.

Cheers,
Kyle Moffett
