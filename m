Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311259AbSCTTj0>; Wed, 20 Mar 2002 14:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293010AbSCTTjS>; Wed, 20 Mar 2002 14:39:18 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:46115 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S292631AbSCTTjJ>; Wed, 20 Mar 2002 14:39:09 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A78062DA0@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Chris Meadors'" <clubneon@hereintown.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: task_struct changes?
Date: Wed, 20 Mar 2002 14:38:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

p_pptr changed to parent and you could just swap them in the code, 

IE:
task_struct->p_pptr would become task_struct->parent

Not sure about the p_opptr, but I bet you'll find the same type of change.  

I found this on Sparc64 as well, if you grep the 2.5.7 patch file, you
should be able to find p_opptr pretty quickly, I bet.

Hope this helps..

Bruce H.

> -----Original Message-----
> From: Chris Meadors [mailto:clubneon@hereintown.net]
> Sent: Wednesday, March 20, 2002 2:48 PM
> To: linux-kernel
> Subject: task_struct changes?
> 
> 
> I'm trying to update some of the code for the Alpha arch.  
> Seems that the
> task_struct struct was changed, but the changes were not 
> reflected in all
> the platforms.
> 
> These two have nailed me so far:
> 
> task_struct->p_opptr
> 
> task_struct->p_pptr
> 
> 
> What were they changed to, and is it just a one line fix, or 
> is it more
> involved?
> 
> -Chris
> -- 
> Two penguins were walking on an iceberg.  The first penguin 
> said to the
> second, "you look like you are wearing a tuxedo."  The second penguin
> said, "I might be..."                         --David Lynch, 
> Twin Peaks
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
