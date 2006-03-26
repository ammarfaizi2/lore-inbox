Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWCZWaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWCZWaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWCZWaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:30:24 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:14824 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751167AbWCZWaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:30:22 -0500
Message-ID: <442715FB.7060404@keyaccess.nl>
Date: Mon, 27 Mar 2006 00:30:19 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: gregkh@suse.de, tiwai@suse.de, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Subject: Re: bus_add_device() losing an error return from the probe() method
References: <44238489.8090402@keyaccess.nl> <20060325175322.1e04852b.akpm@osdl.org>
In-Reply-To: <20060325175322.1e04852b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Looks sane, but please don't sprinkle `return' statements all over a 
> function in this manner.

I actually prefer the multiple returns. You then don't have to "visually 
scroll down" to the label to see what would happen when reading the 
code. Even when there's common code before the return, I've never seen 
GCC not optimise that to the goto form itself. You obviously the boss 
though.

> It's a little surprising that this function returns "OK" if bus==NULL.
> 
> Note that sysfs_create_link() can fail too.  This was one optimistic
> function.

I assume that Greg hasn't commented yet since he's busy rewriting it 
all, so that'll be okay :-)

Rene.

