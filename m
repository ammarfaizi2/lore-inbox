Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286152AbRLJCun>; Sun, 9 Dec 2001 21:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286153AbRLJCue>; Sun, 9 Dec 2001 21:50:34 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:34813 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S286152AbRLJCua>; Sun, 9 Dec 2001 21:50:30 -0500
Date: Sun, 9 Dec 2001 18:41:47 -0800
From: Chris Wright <chris@wirex.com>
To: Britt Park <britt@drscience.sciencething.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The demise of notify_change.
Message-ID: <20011209184147.A27109@figure1.int.wirex.com>
Mail-Followup-To: Britt Park <britt@drscience.sciencething.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C11A2E7.5070306@sciencething.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C11A2E7.5070306@sciencething.org>; from britt@drscience.sciencething.org on Fri, Dec 07, 2001 at 09:19:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Britt Park (britt@drscience.sciencething.org) wrote:
> Somewhen between 2.2.x and 2.4.x notify_change disappeared from 
> super_operations.  What is the accepted practice now for updating an 
> inode's persistent state?  Should one use write_inode for the same 
> purpose or should one rely on file_operations::setattr (excuse the 
> c++ism)? Or is there something entirely different that one should do?

read fs/attr.c::notify_change(), i believe the inode_operations->setattr()
is what you are looking for.

cheers,
-chris
