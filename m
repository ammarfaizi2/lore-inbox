Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131530AbQKZXTs>; Sun, 26 Nov 2000 18:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131338AbQKZXTa>; Sun, 26 Nov 2000 18:19:30 -0500
Received: from 13dyn186.delft.casema.net ([212.64.76.186]:62470 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S132994AbQKZXTY>; Sun, 26 Nov 2000 18:19:24 -0500
Message-Id: <200011262249.XAA10540@cave.bitwizard.nl>
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <Pine.LNX.4.10.10011261942420.11180-100000@yle-server.ylenurme.sise>
 from Elmer Joandi at "Nov 26, 2000 07:53:42 pm"
To: Elmer Joandi <elmer@ylenurme.ee>
Date: Sun, 26 Nov 2000 23:49:13 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:
> 
> Nice to see again a two cutting-edge-killing opinions.
> 
> Every time I really wonder, how such brilliant hackers can be that stupid
> that they can not have cake and eat it the same time, and have to scratch
> each-others eyes every time.
> 
> Use macros.
> 
> Kernel has become so big that it really needs universal  debugging macros
> instead of comments. Comments are waste of brain&fingerpower, if the same
> can be explained by long variable names and debug macros.
> 
> static Subsystem_module_LocalVariableForThisPurpose;
> 
> int Subsytem_module_function_this_and_that(){
> 	DEBUG_ASSERT( Subsystem_module_LocalVariableForThisPurpose  == 0 );
> 	DEBUG_ASSERT(MOST_OF_TIME,FS_AREA,MYFS_MODULE, somethingaboutIndodes->node != NULL )
> }
> 
> 
> Those macros would be acceptable if they are unified and taken to
> kernel configuration level, so it would be easy to switch them in/out 
> not only as boolean option but systematically for different levels,
> subsystems and modules.

I leave "debugging" enabled in the drivers I submit. This allows me to
tell customers who are having "It won't detect my card" problems to
enable the debugging output. Most of the time this leads to a resolution
within minutes of me getting the debugging output log. 

Sure it will slow the driver down a bit, because of all those bit-test
instructions in the driver. If it bothers you, you get to turn it
off. If you are capable of that, you are also capable enough to turn
it back on when neccesary.

The debug asserts that trigger during normal operation are what make
the Linux kernel stable. Problems get spotted at an early
stage. Problems get fixed. Microsoft disables all debugging before
shipping stuff. That means they don't get useful bugreports from the
field ("When I do this, the system sometimes locks...." compared to
"my system crashes with: 'panic: sk buff underrun at 0xc0123456'"). 

This was discussed and a decision was taken that we're on the good
track around 5 years ago. I guess that there is some new blood to be
convinced nowadays...

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
