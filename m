Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSDCMtO>; Wed, 3 Apr 2002 07:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSDCMtF>; Wed, 3 Apr 2002 07:49:05 -0500
Received: from oak.sktc.net ([208.46.69.4]:33284 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S310258AbSDCMsz>;
	Wed, 3 Apr 2002 07:48:55 -0500
Message-ID: <3CAAFA36.80109@sktc.net>
Date: Wed, 03 Apr 2002 06:48:54 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020403140516.C38235-100000@toad.stack.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink wrote:
> How should the FAT driver know that the first FAT is bad if it doesn't
> scan the FAT ? You don't want the second FAT to be used, you want the
> mount to fail, and fsck.xxx to fix the mess. Who tells you that the second
> copy of the FAT is the correct one, and not the first ?

Seems to me you would want a mount-time option to the FAT fs code to say 
"use FAT#<n>", defaulting to the first if no parm given. If that copy of 
the FAT has any problems, fail the mount.

Then you'd want the fsck.fat to have a similar option, saying "use 
FAT#<n> for the check" - that way if the FATs are out of sync, you could 
do a dry run check on each FAT, and go with the one that seemed to be 
better. Perhaps even having the tool allow you to pick and choose if 
needed (although this would probably be better as a seperate tool, that 
allowed you to view a file given a selected FAT and copy it to a clean 
file system.)


