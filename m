Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGHDFG>; Sun, 7 Jul 2002 23:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSGHDFF>; Sun, 7 Jul 2002 23:05:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61593 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316757AbSGHDFE>;
	Sun, 7 Jul 2002 23:05:04 -0400
Message-ID: <3D29019A.6080405@us.ibm.com>
Date: Sun, 07 Jul 2002 20:06:02 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Matthew Wilcox <willy@debian.org>, Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.GSO.4.21.0207072255020.24900-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 8 Jul 2002, Matthew Wilcox wrote:
> 
>>one struct file per open(), yes.  however, fork() shares a struct file,
>>as does unix domain fd passing.  so we need protection between different
>>processes.  there's some pretty good reasons to want to use a semaphore
>>to protect the struct file (see fasync code.. bleugh).
> 
> ??? What exactly do you want to protect there?
> 

I think we were talking about file->private_data

-- 
Dave Hansen
haveblue@us.ibm.com

