Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWCLBCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCLBCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 20:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWCLBCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 20:02:00 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:99 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750759AbWCLBCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 20:02:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] Input: psmouse - disable autoresync
Date: Sat, 11 Mar 2006 20:01:54 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200603110023.38863.dtor_core@ameritech.net> <44131BC9.5020800@rtr.ca>
In-Reply-To: <44131BC9.5020800@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603112001.55358.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 13:49, Mark Lord wrote:
> Dmitry Torokhov wrote:
> > Automatic resynchronization in psmouse driver causes problems on some
> > hardware so disable it by default for now. People with KVM switches
> > that require resync can still enable it via module parameter or sysfs
> > attribute.
> 
> Shouldn't the default be the other way round..
> Existing *compatible* behaviour by default,
> and those who need it can do psmouse.resync_time=0
> 
> ????????????????
> 

Automatic resync code was added at the beginning of 2.6.16 and although it
generally works quite well and usually resolves problems caused by KVMs
resetting mice ther were several reports of it breaking existing setups.
Unfortunately I did not have anough time to resolve the issues in time
for 2.6.16 final and so I think it is the best to disable new code by
default for now. I do not want to revert the changes completely as they
are still useful.

Hope this helps.

-- 
Dmitry
