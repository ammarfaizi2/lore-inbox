Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131353AbQKZSYY>; Sun, 26 Nov 2000 13:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132503AbQKZSYN>; Sun, 26 Nov 2000 13:24:13 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:24821 "EHLO ylenurme.ee")
        by vger.kernel.org with ESMTP id <S131353AbQKZSXx>;
        Sun, 26 Nov 2000 13:23:53 -0500
Date: Sun, 26 Nov 2000 19:53:42 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <Pine.LNX.4.10.10011261942420.11180-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nice to see again a two cutting-edge-killing opinions.

Every time I really wonder, how such brilliant hackers can be that stupid
that they can not have cake and eat it the same time, and have to scratch
each-others eyes every time.

Use macros.

Kernel has become so big that it really needs universal  debugging macros
instead of comments. Comments are waste of brain&fingerpower, if the same
can be explained by long variable names and debug macros.

static Subsystem_module_LocalVariableForThisPurpose;

int Subsytem_module_function_this_and_that(){
	DEBUG_ASSERT( Subsystem_module_LocalVariableForThisPurpose  == 0 );
	DEBUG_ASSERT(MOST_OF_TIME,FS_AREA,MYFS_MODULE, somethingaboutIndodes->node != NULL )
}


Those macros would be acceptable if they are unified and taken to
kernel configuration level, so it would be easy to switch them in/out 
not only as boolean option but systematically for different levels,
subsystems and modules.

elmer.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
