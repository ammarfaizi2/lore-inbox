Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWBMU6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWBMU6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWBMU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:58:39 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:36767 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S964862AbWBMU6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:58:39 -0500
Message-ID: <43F0F2F0.6020907@vilain.net>
Date: Tue, 14 Feb 2006 09:58:24 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any FS with tree-based quota system?
References: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Stromsoe wrote:
> I'm looking for a file system with a tree-based quota system.  XFS on 
> IRIX has projects, but that functionality didn't get ported over to 
> Linux that I can see.

Linux-VServer has some extra quota features, not quite what you're
asking for but perhaps relevant for looking at a patch playing with
quotas on a recent kernel.  The way it works is that you bind mount 
parts of the VFS to another part, and the new mount can have seperate
quota settings.

The most recent split out patch for that is at:
 
http://vserver.13thfloor.at/Experimental/del-2.6.16-rc1-vs2.1.0.9/40_quota.diff

(see it colourised in my gitweb -
http://vserver.utsl.gen.nz/gitweb/?p=vserver.git;a=commitdiff;h=04a1f42903356f18ebdb89613c50923e54506536
)

But it might not stand on its own just yet; it probably at least needs
the Bind Mount Extensions (bme) patch too; it's probably easiest to
apply the entire VServer patch for experimentation.

Sam.
