Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbSK3QAy>; Sat, 30 Nov 2002 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbSK3QAx>; Sat, 30 Nov 2002 11:00:53 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:64246 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267264AbSK3QAx>; Sat, 30 Nov 2002 11:00:53 -0500
Message-ID: <3DE8E271.6090307@yahoo.com>
Date: Sat, 30 Nov 2002 16:08:17 +0000
From: Chris Rankin <rankincj@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: alan@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Massive problems with 2.4.20 module loading
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-30 at 08:49, Martin Loschwitz wrote:
 > I'm having massive problems with Linux 2.4.20 and modul loading.
 > In fact, it seems to have something to do with devfs.

On Sat Nov 30 2002 - 09:36:57 EST, Alan Cox wrote:
 > Linux 2,4.20 doesnt include vmware or ALSA. The fact you list those
 > modules alone suggests that the problem is that you haven't rebuilt
 > them for the new kernel.

Well maybe that's his problem and maybe it isn't, but he's not the only 
person thinking that there's something strange about devfs in 2.4.20. I 
have a 2.4.20-SMP box that is deadlocking when loading modules via 
devfs. The NMI watchdog has produced two oopsen for me, which I have 
published to this list, and while one oops is also from the ALSA 
modules, the other is from mga.o. Both oopsen occur in the 
__write_lock_failed() function and have devfs_open() in the module 
stack. I have most definitely NOT forgotten to recompile everything for 
2.4.20, and I am using symbol versioning anyway.

Chris

