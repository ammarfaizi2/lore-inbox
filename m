Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbULQALI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbULQALI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbULQAJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:09:39 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:40580 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262706AbULQAIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:08:16 -0500
Date: Fri, 17 Dec 2004 01:08:05 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <20041216235147.GC11330@kroah.com>
Message-ID: <Pine.LNX.4.60.0412170101530.25628@alpha.polcom.net>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
 <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com>
 <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com>
 <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net> <20041216235147.GC11330@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Greg KH wrote:
> Disadvantage:
> - it puts a non-process type thing into /proc which is what I am
>   specifically trying to get away from doing.
>
> Only process related things _should_ be in /proc.  Now if I can ever
> fully achieve that goal in my lifetime is something that is left to be
> seen...

Ok, probably - but who said this? IIRC there is no standard describing 
what should be in proc and what should not. I do not think that after so 
many years of storing everyting in /proc there is any chance that you will 
remove all not [0-9]* dirs and files from /proc before the sun will stop 
lighting... :-) Many, really _many_, binary only apps are using proc for 
999999 different (often stupid) things - how you will change that? There 
is way too late for such change, in my opinion.

And polluting / with proc, sys, dev, selinux, debug and who knows what 
else is at least equally bad.


Thanks,

Grzegorz Kulewski

