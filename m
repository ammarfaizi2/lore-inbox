Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSJ3Kqy>; Wed, 30 Oct 2002 05:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbSJ3Kqy>; Wed, 30 Oct 2002 05:46:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19467 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264666AbSJ3Kqx>;
	Wed, 30 Oct 2002 05:46:53 -0500
Message-ID: <3DBFB9FF.1030301@pobox.com>
Date: Wed, 30 Oct 2002 05:52:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Miles Bader <miles@gnu.org>, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> <200210300322.17933.dcinege@psychosis.com> <20021030085149.GA7919@codepoet.org> <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp> <3DBFA0F8.9000408@pobox.com> <20021030093644.GA8423@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>On Wed Oct 30, 2002 at 04:06:00AM -0500, Jeff Garzik wrote:
>  
>
>>Miles Bader wrote:
>>    
>>
>>>[Well, OK, actually it'd be nice to have something like initramfs + some
>>>other sort of fetch-the-bits-directly-from-ROM FS which I could
>>>mix-n-match; anyway initramfs has got to be better than initrd...]
>>>
>>>
>>>      
>>>
>>It should be pretty easy to populate initramfs from ROM...
>>    
>>
>
>I imagine so.  But that still leaves everything in RAM.  On a
>system with just 1 or 2 MB of ram (I have run Linux on such
>things :-) there really isn't much point in trying to use any
>sortof ramfs. 
>
It depends on what you're talking about... if it's just the do_mount.c 
and mount-root-filesystem code, that code gets unlinked and removed from 
RAM completely after the kernel booting completes.

If it's other filesystem data you want hanging around after boot 
completes, check out my reply to Miles... it's doable.

    Jeff



