Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVAOV7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVAOV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVAOV4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:56:03 -0500
Received: from host268.ipowerweb.com ([66.235.211.80]:55303 "HELO
	host268.ipowerweb.com") by vger.kernel.org with SMTP
	id S262330AbVAOVw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:52:57 -0500
Message-ID: <41E990B8.8070100@galaktika.ru>
Date: Sat, 15 Jan 2005 13:52:56 -0800
From: Nick <nick@galaktika.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Can I ask a smbfs question here?
References: <41E87CB1.30804@galaktika.ru> <200501150631.59243.yarick@it-territory.ru>
In-Reply-To: <200501150631.59243.yarick@it-territory.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/usr/sbin/smbmnt ?

After I chmodded /usr/bin/smbmnt one, I got:
libsmb based programs must *NOT* be setuid root.
29612: Connection to nata failed
SMB connection failed

I do not have /usr/sbin/smbmnt

>>not remember which one - found its name in one of FAQs) and specified
>>    
>>
>....
>  
>
>>username=administrator,password=xxx,fmask=0666,codepage=cp866,iocharset=utf8,users 
>>    
>>
>Are you sure it's "users" and not "user" ?
>  
>
I actually tried both. The reaction is the same (may be synonims?).  As 
soon as I specify it, codepage= and iocharset= parameters are no longer 
recognized and an error message starts to appear in the 
/var/log/messages saying that "noexec" parameter is not recognized by 
smbfs (Jan  9 15:24:09 NS kernel: smbfs: Unrecognized mount option 
noexec). This is actually not a big issue as I could write a script with 
"sudo mount /my/mountpoint". And I probably can exclude this line from 
my fstab and specify the parameters in this script. This just does not 
look very user-friendly to me (ok for my single-user laptop). It appears 
that I cannot use fstab with smbfs volumes if I want international 
characters.

>>Any ideas if it is possible to fix this? I can "sudo mount" all the time
>>but it does not sound right...
>>    
>>
>And what's wrong with smbmount ?
>smbmount //server/share /your/mountpoint -o 
>username=<uname>,iocharset=utf8,codepage=cp866
>Works like a charm as long as /usr/sbin/smbmnt is suid-root
>
>  
>
Thanks!
