Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278336AbRJWV7I>; Tue, 23 Oct 2001 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278329AbRJWV6s>; Tue, 23 Oct 2001 17:58:48 -0400
Received: from intranet.resilience.com ([209.245.157.33]:13276 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S278327AbRJWV6o>; Tue, 23 Oct 2001 17:58:44 -0400
Message-ID: <3BD5E71F.6090506@usa.net>
Date: Tue, 23 Oct 2001 14:54:39 -0700
From: Eric <ebrower@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <p05100328b7fb8dcb9473@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both the pivot_root(8) manpage and the <linux>/Documentation/initrd.txt 
document admonish us to do much more than shown below (chroot, relative 
pathing of pivot_root arguments, etc).

I certainly trust HPA's example, but it is a far sight from the
'documented' procedure.  If the pivot_root developers expect
everyone in the world who depended previously on an implicit
change_root to modify their procedures,  they have the
responsibility to see that the "better way" is understood.

If HPA's example is adequate the documentation should be modified.

E

H. Peter Anvin wrote:
> Richard B. Johnson wrote:
> 
>>
>>  Presently, when /initrd/{ash.static} runs off the end of the
>>   /initrd/linuxrc script, the kernel tries to mount the root
>>  defined for LILO. So I add some program that executes 'pivot-root'
>>  instead of just letting the script run off the end?
>>
> 
> 
> You do something like:
> 
> cd /newroot
> pivot_root /newroot /newroot/oldroot
> exec /sbin/init < /dev/console > /dev/console 2>&1
> 
> -

