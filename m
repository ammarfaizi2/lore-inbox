Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVHSTtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVHSTtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVHSTtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:49:21 -0400
Received: from mail-gw2.turkuamk.fi ([195.148.208.126]:28805 "EHLO
	mail-gw2.turkuamk.fi") by vger.kernel.org with ESMTP
	id S965090AbVHSTtU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:49:20 -0400
Message-ID: <430637F4.2050402@kolumbus.fi>
Date: Fri, 19 Aug 2005 22:50:12 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       vandrove@vc.cvut.cz, Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk> <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk> <4306301F.9060707@kolumbus.fi> <20050819194045.GG29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050819194045.GG29811@parcelfarce.linux.theplanet.co.uk>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 19.08.2005 22:49:12,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 19.08.2005 22:49:34,
	Serialize complete at 19.08.2005 22:49:34
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Fri, Aug 19, 2005 at 10:16:47PM +0300, Mika Penttilä wrote:
>  
>
>>Just out of curiosity - what protects even local filesystems against 
>>concurrent truncate and symlink resolving when using the page cache helpers?
>>    
>>
>
>How do you get truncate(2) or ftruncate(2) to do something with a symlink?
>The former follows links, the latter takes an open file...
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Yes that is right, there is no way to invalidate the symlink inode 
mapping page(s) from user space.

--Mika




