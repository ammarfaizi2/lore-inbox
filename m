Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVCWJnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVCWJnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCWJnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:43:37 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:34994 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261220AbVCWJnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:43:13 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.11-mm4 and 2.6.12-rc1-mm1
Date: Wed, 23 Mar 2005 10:42:46 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org> <200503170942.25833.petkov@uni-muenster.de> <20050317011811.69062aa0.akpm@osdl.org>
In-Reply-To: <20050317011811.69062aa0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503231042.47249.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 March 2005 10:18, Andrew Morton wrote:
> Borislav Petkov <petkov@uni-muenster.de> wrote:
> > Mar 17 09:19:28 zmei kernel: [    4.109241] PM: Checking swsusp image.
> >  Mar 17 09:19:28 zmei kernel: [    4.109244] PM: Resume from disk failed.
> >  Mar 17 09:19:28 zmei kernel: [    4.112220] VFS: Mounted root (ext2
> > filesystem) readonly. Mar 17 09:19:28 zmei kernel: [    4.112465] Freeing
> > unused kernel memory: 188k freed Mar 17 09:19:28 zmei kernel: [   
> > 4.142002] logips2pp: Detected unknown logitech mouse model 1 Mar 17
> > 09:19:28 zmei kernel: [    4.274620] input: PS/2 Logitech Mouse on
> > isa0060/serio1 [EOF]
> >  <-- and here it stops waiting forever. What actually has to come next is
> > the init process, i.e. something of the likes of:
> >  INIT version x.xx loading
> >  but it doesn't. And by the way, how do you debug this? serial console?
>
> Serial console would be useful.  Do sysrq-P and sysrq-T provide any info?
> -
<snip>

Hi Andrew,

I've tried 2.6.12-rc1-mm1 today and it stops booting at the same point as 
2.6.11-mm4. What might help is the info that rc1 boots just fine so it is 
something in the mm series that impedes the boot process. However, sysrq-P 
and sysrq-T do not provide anything - sysrq doesn't show any activity at all, 
i.e. it doesn't even print the usage info message. Infact, the keyboard is 
dead, it doesn't even turn on or off any lights (NumLock etc).

Any ideas? (Additional printk's added manually, etc..)

Regards,
Boris.
