Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUBXOjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUBXOjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:39:51 -0500
Received: from vsmtp1alice.tin.it ([212.216.176.141]:54511 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S262256AbUBXOjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:39:46 -0500
Message-ID: <403B7402.2000008@universitari.crocetta.org>
Date: Tue, 24 Feb 2004 15:55:46 +0000
From: Alessandro Salvatori <a.salvatori@universitari.crocetta.org>
Reply-To: sandr8@crocetta.org
User-Agent: Mozilla Thunderbird 0.5 (X11/20040221)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gautam Pagedar <gautam@cins.unipune.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: can i modify ls
References: <005601c3fd75$1c681510$8c01080a@crayii>
In-Reply-To: <005601c3fd75$1c681510$8c01080a@crayii>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a directory is a file. it has got its own rights, that are rights 
referred to that particular file. maybe you should not allow people to 
use ls and make them use your own ls_patched but they still could give a 
"echo *" command which would be expanded by bash or other shells... 
so... what could you do with that? are you going to patch any shell you 
give access to?
let me know, it's quite interesting...
cheers
Alessandro Salvatori

Gautam Pagedar wrote:

>Hello Everyboy.
>   i am new to this mailing list, so please bear with me if i don't follow
>certain rules till i get used to it.  I am a research student and currently
>working on a project to tweak the working of 'ls' command depending on my
>requirement. I have observed that 'ls' show ALL THE FILES and DIRECTORIES in
>a particular location even though a user has no access rights to it. I want
>to hide all
>such files for that particular user.
>
>The Algorithm i beleive should work like this when an 'ls' command is
>called.
>
>1. Check the current directory.
>2. Extract the files or directory to be displayed.
>3. Check the user permissions for these files.
>4. Display only those files wher user had either read, write or execute
>access for all owner,group and others.
>
>I have found out that 'ls' uses getdents64() system call for gathering the
>directory information. How do i move ahead from here.
>
>Regards,
>Gautam Pagedar
>Centre for Information and Network Security
>
>
>
>
>
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

