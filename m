Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTIGIFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 04:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIGIFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 04:05:07 -0400
Received: from maverick.eskuel.net ([81.56.212.215]:51941 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S262836AbTIGIFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 04:05:01 -0400
Message-ID: <3F5AE6EB.4000308@eskuel.net>
Date: Sun, 07 Sep 2003 10:06:03 +0200
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Fs corruption with swsusp in test4-mm6 ?
References: <3F59A913.1080406@eskuel.net> <20030906212206.GA26916@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030906212206.GA26916@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pavel Machek wrote:
> Hi!
> 
> 
> 
>>I've tested the latest -mm6 kernel on a Compaq Presario 2157EA laptop 
>>(Celeron Mobile 2GHz)
>>Everything worked fine until I tested suspend to disk. After resuming, 
>>I've got random messages about reiserfs problem on the console :
>>
>>vs-4080: reiserfs_free_block: free_block (hda2:95121)[dev:blocknr]: bit 
>>already cleared
>>Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: 
>>free_block (hda2:95122)[dev:blocknr]: bit already cleared
>>Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
>>of object [689 645 0x0 SD] (nlink == 1) not found (pos 25)
>>Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
>>of object [689 652 0x0 SD] (nlink == 1) not found (pos 25)
>>
>>Please find in attachement 1 syslog showing the suspend / resume cycle 
>>and the fs errors.
> 
> 
> Be sure to reboot then run reiserfsck.
> 
> OHCI lacks suspend/resume support. Turn it off. ... ... but it should
> not do this kind of corruption. Can you reproduce this without OHCI?
> Can you try -test3?
> 								Pavel
> 


When I tested -test3 a few week ago, I hadn't got this problem.

Mathieu LESNIAK

