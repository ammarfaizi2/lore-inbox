Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272121AbTHHXsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272124AbTHHXsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 19:48:54 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:56071 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272121AbTHHXsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 19:48:53 -0400
Date: Sat, 9 Aug 2003 01:48:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Dheeraj <dheeraj@ece.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : Strange logs while using Scroll-Lock key
Message-ID: <20030809014851.A8496@pclin040.win.tue.nl>
References: <20030808164800.GA2952@bharati>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030808164800.GA2952@bharati>; from dheeraj@ece.gatech.edu on Fri, Aug 08, 2003 at 12:48:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 12:48:00PM -0400, Dheeraj wrote:
> 1) I got these strange logs while i was using the console and tried to remap
>     my caplock key to control key using loadkeys.

You tell us what you attempted to do, but not what you did.

I did

% dumpkeys | head -1
keymaps 0-15
% loadkeys
keymaps 0-15
keycode 58 = Control
%

and lo! my capslock key was turned into a control key.

But afterwards all is well - even better than before: no more CapsLock.
No problems with anything I tried.

So, if you can reproduce a buggy situation, please describe the steps.

Andries


[For people trying this: do not simplify the above into
% loadkeys
keycode 58 = Control
%
for this turns the CapsLock on the plain map into a control key,
so that when this key is down the control map is used, and then
the key up event will be a CapsLock up.
That is why it is necessary to tell loadkeys to change the entry
in all existing keymaps simultaneously.
This holds for all modifier keys.]

