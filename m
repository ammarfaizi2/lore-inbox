Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290512AbSAQWsO>; Thu, 17 Jan 2002 17:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290514AbSAQWsE>; Thu, 17 Jan 2002 17:48:04 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:35036 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290512AbSAQWry>; Thu, 17 Jan 2002 17:47:54 -0500
Date: Thu, 17 Jan 2002 17:47:53 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BLKGETSIZE64 (bytes or sectors?)
Message-ID: <20020117174753.H18086@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0201171420100.2747-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201171420100.2747-100000@localhost.localdomain>; from Matt_Domsch@Dell.com on Thu, Jan 17, 2002 at 02:28:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 02:28:52PM -0600, Matt Domsch wrote:
> Is the BLKGETSIZE64 ioctl supposed to return the size of the device in 
> bytes (as the comment says, and is implemented in all places *except* 
> blkpg.c), or in sectors (as is implemented in blkpg.c since 2.4.15)?
> 
> It would seem that blkpg.c gets it wrong, that it should be in bytes.  
> Assuming that's the case, here's the patch to fix it against 2.4.18-pre4.

blkpg.c is wrong -- the size has to be in bytes in order to support weird 
sector sizes.

		-ben
