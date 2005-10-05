Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVJEU1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVJEU1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVJEU1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:27:19 -0400
Received: from 10.ctyme.com ([69.50.231.10]:47010 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1030374AbVJEU1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:27:17 -0400
Message-ID: <43443723.907@perkel.com>
Date: Wed, 05 Oct 2005 13:27:15 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz>
In-Reply-To: <E1EMutG-0001Hd-7U@be1.lrz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bodo Eggert wrote:

>Marc Perkel <marc@perkel.com> wrote:
>
>[...]
>  
>
>>I'll run through a few ideas here.
>>    
>>
>
>  
>
>>Novell Netware type permissions. ACLs are a step in the right direction
>>but Linux isn't any where near where Novell was back in 1990. Linux lets
>>you - for example - to delete files that you have no read or write
>>access rights to.
>>    
>>
>
>It lets you unlink them. That's different from deleting, since the owner
>may have his/her private link to that file.
>
>Unlinking is changing the contents of a directory, and it's controlled by
>the write permission of the containing directory.
>
>  
>
There would be different rights to eack link.

>>Netware on the other hand prevents you from deleting
>>files that you can't write to and if you have no right it is as if the
>>file isn't there.
>>    
>>
>
>Imagine a /tmp directory (writable by world) with user "a" creating a file
>"foo", umask=077 and user "b" trying to do the same. User "b" will get
>'file exists' if he tries to create it, and 'file does not exist' if he
>tries to list it. He will go nuts.
>  
>
Users should have private temp directory space. Two user trying to 
create the same file in the same directory isn't going to work under any 
operating system.

>BTW: YANI: That about a tmpfs where all-numerical entries can only be
>created by the corresponding UID? This would provide a secure, private
>tmp directory to each user without the possibility of races and denial-of-
>service attacks. Maybe it should be controlled by a mount flag.
>
>  
>
>>You can't even see it in the directory. Netware also
>>has inherited permissions like Windows and Samba has and this is doing
>>it right.
>>    
>>
>
>You can't do that if you have hardlinks. However, I missed the feature of
>overruling file permissions in some special directories, e.g. anything
>put under /pub should ignore umask and be a+rX.
>  
>
You have to realize the Netware does things differently and that Linux 
limitations don't apply to Netware.

>  
>
>>File systems and individual directories should be able to be
>>flagged as casesensitive/insensitive.
>>    
>>
>
>IMHO not needed.
>  
>
But just because you don't need it doesn't mean other people don't. If 
you are running Samba pretending to be a case insensitive file system 
then this is a good feature.

