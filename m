Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTEESex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTEESex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:34:53 -0400
Received: from watch.techsource.com ([209.208.48.130]:52980 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261214AbTEESd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:33:29 -0400
Message-ID: <3EB6B22B.7090009@techsource.com>
Date: Mon, 05 May 2003 14:49:15 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: thunder7@xs4all.nl, Gabe Foobar <foobar.gabe@freemail.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: will be able to load new kernel without restarting?
References: <freemail.20030403212422.18231@fm9.freemail.hu>            <20030503205656.GA19352@middle.of.nowhere> <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:
  but I don't see any easy way
> to implement rmmmod/insmod semantics for things like kernel/schedule.c (how
> would you get your next timeslice?). 

This isn't such a silly idea, really.

How much code would be required for a default, completely brainless 
scheduler?  That's built-in.  When you load a new scheduler, the default 
one doesn't get kicked out; it just gets turned off.  When you unload, 
the default takes over.

The only major issue is that the data structures used to manage 
processes would be different from one scheduler to the next.  One 
possible answer would be to have an unloading driver translate all of 
its process information into the default scheduler's format.  A newly 
loaded one would translate it to its own format.  Things that would be 
lost in the translation include interactivity information, etc.

Please forgive my total ignorance about how processes are represented in 
data structures in the linux kernel.

