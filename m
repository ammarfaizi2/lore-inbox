Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbUCOXU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUCOXU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:20:29 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:29948 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262853AbUCOXU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:20:27 -0500
Message-ID: <40563A2B.4040800@nortelnetworks.com>
Date: Mon, 15 Mar 2004 18:20:11 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
References: <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
In-Reply-To: <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> Assuming one RW on top of a RO only now: What should happen when a
> file/directory is missing from the top? If the bottom one "shows through",
> you can't delete anything; if it doesn't, you win nothing (because you will
> have to keep a complete copy RW on top).

I don't see how you win nothing.  I create an overlay filesystem.  I 
delete a bunch of files in the overlay and it doesn't show through.  All 
my other files are still links to the originals, with the

I would dearly love to use something like to make it easy to track 
changes made all over a source tree.  If I could sync them up at the 
begining, then make all my changes in the overly, then doing a diff is 
really easy since you just look for places where the inodes are 
different between the two filesystems.  Like having hard links, but the 
filesystem breaks them for you when you write.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
