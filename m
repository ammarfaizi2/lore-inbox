Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbVJEOlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVJEOlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVJEOlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:41:25 -0400
Received: from 10.ctyme.com ([69.50.231.10]:51948 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S965182AbVJEOlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:41:23 -0400
Message-ID: <4343E611.1000901@perkel.com>
Date: Wed, 05 Oct 2005 07:41:21 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: 7eggert@gmx.de, Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>	<E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
In-Reply-To: <87k6gsjalu.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nix wrote:

>On 4 Oct 2005, Bodo Eggert stated:
>  
>
>>BTW: YANI: That about a tmpfs where all-numerical entries can only be
>>created by the corresponding UID? This would provide a secure, private
>>tmp directory to each user without the possibility of races and denial-of-
>>service attacks. Maybe it should be controlled by a mount flag.
>>    
>>
>
>Wouldn't it be less kludgy to just use the existing private namespace
>stuff to provide each user with its own /tmp? (Or each user's session,
>rather, which is probably much easier, as that corresponds precisely to
>one process tree).
>
>  
>

If you were going to do it right here's what you would do:

People who had files in /tmp would have no rights at all to other users 
/tmp files.
Listing the dirtectory would only display the files you had some access 
to. If you have no rights you don't even see that the file is there.
The effect would be like giving people their own tmp directories.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

