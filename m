Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUITNTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUITNTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUITNTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:19:49 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:2820 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266511AbUITNTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:19:39 -0400
Message-ID: <414EDA10.7050304@hist.no>
Date: Mon, 20 Sep 2004 15:24:32 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD>
In-Reply-To: <20040920105950.GI5482@DervishD>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:

>    Hi Olaf :)
>
> * Olaf Hering <olh@suse.de> dixit:
>  
>
>>>then /etc/mtab can die. Comments? Better solutions?
>>>      
>>>
>>Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
>>introduced. So, kill it today from your mount binary! TODAY. ...
>>    
>>
>
>    Bad idea... ;))) I upgraded my 'mount' yesterday. I was using a
>mount from Debian, from 1998 more or less, that worked flawlessly
>except for the '--bind' feature and things like those. I used
>/etc/mtab as a symlink to /proc/mounts, and all worked OK except for
>the double root entry and the need to manually call losetup to delete
>unused /dev/loop entries.
>
>    But after the upgrade I no longer could umount a filesystem that
>I mounted as 'user', because the device is a symlink and the 'user'
>option is not stored in /proc/mounts. So my problems were:
>  
>
Using a mtab that is a link to /proc/mounts fails with quota too.
Quta tools read /etc/mtab looking for "usrquota" and or "grpquota"
mount options.  These appear in a normal /etc/mtab but not in /proc/mounts,

so the tools gets the mistaken impression that no fs actually use quotas.

Helge Hafting
