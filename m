Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268368AbTBSMIh>; Wed, 19 Feb 2003 07:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268373AbTBSMIh>; Wed, 19 Feb 2003 07:08:37 -0500
Received: from isdn222.s.netic.de ([212.9.162.222]:10112 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S268368AbTBSMIg>;
	Wed, 19 Feb 2003 07:08:36 -0500
Date: Wed, 19 Feb 2003 13:19:09 +0100 (MET)
Message-Id: <20030219.131909.59461826.mccramer@s.netic.de>
To: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <200302191052.47663.baldrick@wanadoo.fr>
References: <20030219073221.GR29983@holomorphy.com>
	<20030219.095905.92587466.mccramer@s.netic.de>
	<200302191052.47663.baldrick@wanadoo.fr>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Date: Wed, 19 Feb 2003 10:52:47 +0100
Message-ID: <200302191052.47663.baldrick@wanadoo.fr>

Hi,

 yes, indeed, this was the problem!!! (by the way: HURRAY, IT BOOTS!)

 It seems that loading an "old" config file from the 2.4.*-series
 of linux kernels will WIPE OUT that config items since they are not 
 written back to disk anymore when saving kernel configuartions....

 Another thing is that make menuconfig fails to write back
 configurations as alternate files into directories owned by root
 and set drwxr-xr-x....but it is able to write into the . directory,
 even if it is set with drwxr-xr-x also...
 
 But this is only a sideeffect.

 Keep Hacking!
 Meino
 


> This is becoming a FAQ!  Did you enable the console in your .config?
> 
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> 
> Most likely you chose to compile the input system as a module, which
> caused the console options to be autohorribly deselected.  Just say 'y'
> for the input subsystem, at which point the console options will reappear,
> letting you select them.
> 
> I hope this helps,
> 
> Duncan.
> 
