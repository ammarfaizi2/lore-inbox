Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTELDKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTELDKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:10:41 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:40669 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261861AbTELDKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:10:39 -0400
Message-ID: <3EBF1398.9090704@nortelnetworks.com>
Date: Sun, 11 May 2003 23:23:04 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone ever implemented a reparent(pid) syscall?
References: <3EBBF965.4060001@nortelnetworks.com> <20030510063936.D13069@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
 > Chris Friesen wrote:
 >
 >> I would like some way for the main one to restart, read the list of pids
 >> out of a file that it conveniently stashed away,

 > And until it has done this, any child death will still only be seen by init.
 > So you either didn't have a problem with this in the first place, or you
 > can make sure your children don't die while their parents are changing, or
 > you've just designed yourself a race condition.

Sure. So the monitorer starts up, attempts to watch a pid, gets an error saying
that it doesn't exist, and handles it.

In the particular case that I'm planning for, the processes in question are 
long-running ones which should never die except for upgrades (which could be 
designed for).

The general case would be trickier.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

