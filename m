Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVKVRYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVKVRYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVKVRYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:24:55 -0500
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:34573 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S965024AbVKVRYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:24:54 -0500
Message-ID: <43835464.9040808@francetelecom.com>
Date: Tue, 22 Nov 2005 18:24:52 +0100
From: VALETTE Eric RD-MAPS-REN <eric2.valette@francetelecom.com>
Reply-To: eric2.valette@francetelecom.com
Organization: Frnace Telecom R&D
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org
Subject: Re: CIFS improvements/wider testing needed
References: <4381EFF3.8000201@austin.rr.com> 	<4382032D.4080606@francetelecom.com> <43823CB3.8090303@austin.rr.com> 	<438323AC.2090102@francetelecom.com> <43834994.10006@austin.rr.com>
In-Reply-To: <43834994.10006@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 17:24:52.0430 (UTC) FILETIME=[A5FCE6E0:01C5EF89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> VALETTE Eric RD-MAPS-REN wrote:
> 
>>Steve French wrote:
>>  
>>
>>>VALETTE Eric RD-MAPS-REN wrote:
>>>
>>>    
>>>
>>>>Steve French wrote:
>>>> 
>>>>
>>>>      
>>>>
>>>>>Eric,
>>>>>  
>>>>>        
>>>>>
>>>>Well I would be surprised the "cat >> titi" command does any of this
>>>>byte range lock. If the "create and later rewrite the same file"
>>>>sequence fails, with a simple cat command (cat > titi ... ^D; cat >>
>>>>titi), how can it works with complicated applications?
>>>>
>>>> 
>>>>
>>>>      
>>>>
>>>Make sure that you let me know if your cat example works when mounted
>>>with the relatively new "noperm" mount option on the client.   At least
>>>then we will know whether we are looking at a problem with access
>>>control on the server (ntfs acls) or client (unix mode bits and the
>>>.permission entry point)
>>>    
>>>
>>
>>Works with the "noperm" mount option.
>>
>>--eric
>>
>>  
>>
> Could you run "stat titi" and/or "ls -l titi" between the
>     "cat > titi"
> and the
>     "cat >> titi"

cat > toto
toto
8 r-ptxp-ceva6380:/network/home/test3->ls -l toto
-rw-r--r-- 1 root root 5 2005-11-22 17:50 toto
9 r-ptxp-ceva6380:/network/home/test3->cat >>titi
tata
10 r-ptxp-ceva6380:/network/home/test3->ls -l toto
-rw-r--r-- 1 root root 5 2005-11-22 17:50 toto

OK, I'm not root.root but why does my identity seem to change between
the file creation and the file rewrite?

-- eric
