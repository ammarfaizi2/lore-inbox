Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTDJRYL (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTDJRYL (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:24:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51209 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264112AbTDJRYK (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 13:24:10 -0400
Date: Thu, 10 Apr 2003 10:35:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Riley Williams <Riley@Williams.Name>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-English user messages
In-Reply-To: <BKEGKPICNAKILKJKMHCAGEPFCFAA.Riley@Williams.Name>
Message-ID: <Pine.LNX.4.44.0304101033030.8329-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Apr 2003, Riley Williams wrote:
> 
> Whilst I agree with the general sentiments above, any such code would
> require some sort of code attached to each message for it to look up,

No.

I've used VMS, and error code number encoding is a total heap of crap.

If you can't translate the message based on the _message_, then don't
bother. I'm not adding codes for different errors, it becomes just an
unreadable mess, and adds _zero_ to stability or readability, and it's
horrible for maintenance - suddenly you need to worry about silly numbers
for anything you print out, so you stop printing stuff or you re-use codes
that don't make sense.

The road to hell is paved with good intentions. This is one of those "good 
intentions" things - it sounds like it's a nice helper thing, but it's 
nothing but a load of maintenance headaches and causes horrible printout 
headaches.

		Linus

