Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbULAHdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbULAHdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 02:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULAHdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 02:33:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54975 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261325AbULAHdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 02:33:01 -0500
Message-ID: <41AD73B0.8080004@us.ibm.com>
Date: Wed, 01 Dec 2004 01:33:04 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: eyal@eyal.emu.id.au, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org
Subject: Re: 2.6.10-rc2-mm4 - cifs.ko needs unknown symbol CIFSSMBSetPosixACL
References: <41AD67E0.9070207@us.ibm.com> <20041130225303.7abb16b8.akpm@osdl.org>
In-Reply-To: <20041130225303.7abb16b8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steve French <smfltc@us.ibm.com> wrote:
>  
>
>> The CIFS code has had major recent update (most importantly the 
>> cifs_readdir rewrite which can be enabled in mm by "echo 1 > 
>> /proc/fs/cifs/NewReaddirEnabled",
>>    
>>
>
>Nobody will do that, so the new code won't get tested.
>
>In keeping with my evil plan to drive -mm users insane, could I ask that
>you send me a diff which will make the new readdir code default to "on"?
>
>  
>

OK - done.  Default is now to use cifs_readdir2 (new code) and to go 
back to the old code -
      "echo 1 > /proc/fs/cifs/ReenableOldCifsReaddirCode"

The update is in the cifs bk tree (bk://cifs.bkbits.net/linux-2.5cifs) 
and this particular minor patch in diff -Nau form is:

http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@41ad739b4xCWzpJKDse0JW4Ep5y3LQ
