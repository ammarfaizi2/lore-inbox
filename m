Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbTL3SWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 13:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbTL3SWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 13:22:25 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:30206 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265884AbTL3SWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 13:22:22 -0500
Date: Wed, 31 Dec 2003 07:20:36 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software suspend in 2.6.0
In-reply-to: <200312300000.05201.rob@landley.net>
To: rob@landley.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Message-id: <1072808436.2741.34.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200312300000.05201.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

Do you have a preemptive kernel? If so, it could be that you're getting
'bad scheduling while atomic' messages. Could you check dmesg after the
second suspend?

Regards,

Nigel

On Tue, 2003-12-30 at 19:00, Rob Landley wrote:
> Since Patrick fell off the face of the earth, I've switched to Pavel's suspend 
> code, which pretty much works the same way, but has some similar rough edges.
> 
> The first suspend works nicely.  After resuming from that and suspending 
> again, the screen gets blanked early in the suspend (immediately after 
> "suspending processes", and then the suspend is REALLY SLOW.  (You can see 
> the hard drive light light up and go off again with a 1/2 second gap between 
> each page saved.)
> 
> I think that what's happening is that during the "power stuff down" phase, the 
> device list is including the screen and processor and powering them down.  
> The processor goes into an insanely slow state, and the display is black.  
> (The suspend will usually complete normally when this happens, if you give it 
> 10 minutes.)
> 
> It doesn't do this on the first suspend, but it does it on second and later 
> suspends.
> 
> Any suggestions?
> 
> Rob
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

