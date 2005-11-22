Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVKVKhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVKVKhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVKVKhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:37:07 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:33031 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S964896AbVKVKhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:37:06 -0500
Message-ID: <4382F4C9.3020307@francetelecom.com>
Date: Tue, 22 Nov 2005 11:36:57 +0100
From: VALETTE Eric RD-MAPS-REN <eric2.valette@francetelecom.com>
Reply-To: eric2.valette@francetelecom.com
Organization: Frnace Telecom R&D
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CIFS improvements/wider testing needed
References: <4381EFF3.8000201@austin.rr.com> 	<4382032D.4080606@francetelecom.com> <43823CB3.8090303@austin.rr.com>
In-Reply-To: <43823CB3.8090303@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 10:36:57.0012 (UTC) FILETIME=[A9807F40:01C5EF50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> VALETTE Eric RD-MAPS-REN wrote:
> 
>> Steve French wrote:
>>  
>>
>>> Eric,
>>>   
>>
>> Well I would be surprised the "cat >> titi" command does any of this
>> byte range lock. If the "create and later rewrite the same file"
>> sequence fails, with a simple cat command (cat > titi ... ^D; cat >>
>> titi), how can it works with complicated applications?
>>
>>  
>>
> Make sure that you let me know if your cat example works when mounted
> with the relatively new "noperm" mount option on the client.   At least
> then we will know whether we are looking at a problem with access
> control on the server (ntfs acls) or client (unix mode bits and the
> .permission entry point)

The simple "cat > titi ..^D ; cat >> titi" case works when mounted with
the noperm option.

BTW : the fstab content is now :

\\r-canaris\ceva6380    /network/home cifs
domain=FTRD,noperm,credentials=/home/ceva6380/.s
ambaShareId 0 0

and the .sambaShareId contains my windows domain (FTRD) login id (same
as $USER value BTW) and the associated password and "umask" at shell
prompts return 0022.

Hope this helps.

--eric
