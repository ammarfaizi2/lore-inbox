Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTKGWTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTKGWS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:18:29 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:21263 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S264338AbTKGNjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 08:39:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Simon Haynes <simon@baydel.com>
Reply-To: simon@baydel.com
Organization: Baydel Ltd.
To: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: SFFDC and blksize_size
Date: Fri, 7 Nov 2003 13:12:54 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <37CC93E8710D@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been writing a block driver for SSFDC compliant SMC cards. This stuff 
allocates 16k blocks.  When I get requests the transfers are split into the 
size I specifty in the blksize_size{MAJOR] array. It sems that most things 
set this to 1k. In my case this causes a performance problem  as I have to 
end up doing 16 * (16K write,  16K read, 16k erase)  to write and verify a 
16k block which has been previously written.
 
I increased this size to 4k and now I only need 4 * this lot. !deally I would 
like to do 1. However if I set the block size to 16k the module installation 
crashes when I call register_disk. 

I guess I could deal with the request queue myself but I would just like to 
know if there is a 4k limit or I have some other bug.

Many Thanks

Simon.
