Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWBMTDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWBMTDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWBMTDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:03:39 -0500
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:14013 "EHLO
	smtp-1.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S964791AbWBMTDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:03:38 -0500
Date: Mon, 13 Feb 2006 11:03:35 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: any FS with tree-based quota system?
Message-ID: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for a file system with a tree-based quota system.  XFS on IRIX 
has projects, but that functionality didn't get ported over to Linux that 
I can see.

I'm building a closed-box system to serve web pages.  I expect to have 20k 
to 30k different user trees.  User's will not have direct access to the 
box and will not be assigned a uid/gid.  Every tree will be owned by the 
same uid/gid.

I would like to be able to apply a quota to a particular tree, and have 
every file and directory in the path of that tree count toward that tree's 
quota usage.  I can prevent hard links across trees.

I noticed that Neil Brown wrote some patches fairly early on in the 2.4 
cycle to do tree-based quota by UID.  The last patch-set I found was 
against 2.4.14 (http://cgi.cse.unsw.edu.au/~neilb/patches/linux/2.4.14/) 
from late 2001, and did not come with patches to quota-tools.

How much change has the quota system undergone between 2.4.14 and 2.4.32? 
Between 2.4 and 2.6?  What can I read to get a decent understanding of FS 
basics and how the quota system interacts?  Any pointers at all would be 
appreciated.  (I'm equally open to "that's the stupidest idea I've ever 
heard" as well, or pointers to reasons why it wouldn't be workable.)

Thanks.


-Chris
