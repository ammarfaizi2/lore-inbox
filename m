Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTGTFZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 01:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTGTFZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 01:25:25 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:28647 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261825AbTGTFZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 01:25:24 -0400
To: David Dillow <dave@thedillows.org>
Cc: linux-kernel@vger.kernel.org,
       Phillip Lougher <phillip@lougher.demon.co.uk>
Subject: Re: [PATCH] Port SquashFS to 2.6
References: <7vk7ae15ty.fsf@assigned-by-dhcp.cox.net>
	<1058657738.4233.4.camel@ori.thedillows.org>
From: junkio@cox.net
Date: Sat, 19 Jul 2003 22:40:22 -0700
In-Reply-To: <1058657738.4233.4.camel@ori.thedillows.org> (David Dillow's
 message of "19 Jul 2003 19:35:38 -0400")
Message-ID: <7vu19hrc1l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DD" == David Dillow <dave@thedillows.org> writes:

DD> On Sat, 2003-07-19 at 18:59, junkio@cox.net wrote:
>> ...
>> +	while(length < index) {
>> +		char buffer[PAGE_CACHE_SIZE];
 
DD> Hmm, isn't that 4K allocated on the stack? Ouch.

Ouch indeed.  I was not looking for these things (I was just
porting not fixing).  Thank you for pointing it out.  Have a
couple of questions:

 - Would it be an acceptable alternative here to use blocking
   kmalloc upon entry with matching kfree before leaving?

 - I would imagine that the acceptable stack usage for functions
   would depend on where they are called and what they call.
   Coulc you suggest a rule-of-thumb number for
   address_space_operations.readpage (say, would 1kB be OK but
   not 3kB?)

 - Would the same rule apply to 2.4 filesystem layer?

