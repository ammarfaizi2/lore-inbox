Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTKXUzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKXUzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:55:04 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:6281 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261476AbTKXUzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:55:01 -0500
Message-ID: <3FC27019.7010402@myrealbox.com>
Date: Mon, 24 Nov 2003 12:54:49 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
References: <fa.hevpbbs.u5q2r6@ifi.uio.no> <fa.l1quqni.v405hu@ifi.uio.no>
In-Reply-To: <fa.l1quqni.v405hu@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

> 
> In any case, if a user is *MAKING* a program set-UID, it's probably because
> he *wants* it to run as himself even if others invoke it (otherwise, he
> could just leave it in ~/bin and be happy).  So this is really a red herring,
> as it's only a problem if (a) he decides to get rid of the binary, and fails
> to do so because of hard links he doesn't know about, or (b) he's an idiot
> programmer and it malfunctions if invoked with an odd argv[0]....

Right... but non-privileged users _can't_ delete these extra links, even 
if they notice them from the link count.  And non-idiots do make 
security errors -- they just fix them.  But in this case, fixing the 
error after the fact may be impossible without root's help.

And how many package managers / install scripts check for hard links of 
files they're about to overwrite?

--Andy

