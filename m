Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTLRIkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTLRIkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:40:13 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:32162 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265300AbTLRIkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:40:07 -0500
Date: Thu, 18 Dec 2003 00:39:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: jshankar <jshankar@CS.ColoState.EDU>
Cc: Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 file system
Message-ID: <20031218083957.GA6438@matchmail.com>
Mail-Followup-To: jshankar <jshankar@CS.ColoState.EDU>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <3FE23273@webmail.colostate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE23273@webmail.colostate.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 09:47:59PM -0700, jshankar wrote:
> Hello Hans,
> 
> >Filesystems don't usually wait on the IO to complete before submitting
> >more IO in response to the next write() syscall.  They can do this by
> >batching a whole bunch of operations into one committed transaction.
> >
> 
> Is there a timeout mechanism for batching operations. What if certain 
> operation
> is done after the batch operation is executed. Does it mean that the new 
> operation has to wait.

You don't have to wait unless you run out of available non-dirty memory, or
issue a call to sync to the disks.
