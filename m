Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUJYBo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUJYBo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUJYBo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:44:56 -0400
Received: from mailgate0.sover.net ([209.198.87.43]:58819 "EHLO mx0.sover.net")
	by vger.kernel.org with ESMTP id S261650AbUJYBox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:44:53 -0400
Message-ID: <417C5A91.40008@sover.net>
Date: Sun, 24 Oct 2004 21:44:49 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
CC: linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <Pine.LNX.4.58.0410232104510.3984@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0410232104510.3984@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

>Geert Uytterhoeven wrote:
>  
>
>> <>On Wed, 20 Oct 2004, Jon Smirl wrote:
>
>>>If you implement VGA you will be able to boot and work in any x86
>>>system without writing any code other than the BIOS.
>>>      
>>>
>>Ugh... I prefer _not_ to have VGA compatibility.
>>    
>>
>If you want to be able to see the BIOS, you'll need some legacy emulation,
>but it should be enough to implement MDA output.
>  
>
Nope.  The PC BIOS looks for "expansion ROMs", and calls initialization 
routines in the ones it finds.  It then expects to be able to call INT 
10 to position the cursor and print text (and read the cursor position, 
what's on screen, etc.).  You could have a BIOS on a network card that 
provides the necessary interrupt routines, but actually talks to a 
remote X server for display functions.  (yes - it might need to 
advertise itself as a video device for this to work)

>Since some VGA cards used to depend on the MDA/CGA BIOS routines, most
>(all?) BIOS variants will implement all nescensary IO functions. You'll
>need some MDA registers for the cursor position (that don't even clash with
>EGA/VGA/CGA), 4K mapped memory at B000:0000 and a loop translating the text.
>  
>
Right - all video cards provide these BIOS routines (including one the 
one being considered here).  They aren't in the system BIOS.  (Not that 
there are no broken BIOSes around, but strictly speaking, there is no 
need at all for the system BIOS to know anything about the display card 
being used)

- Steve

