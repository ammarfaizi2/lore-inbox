Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280674AbRLHOHH>; Sat, 8 Dec 2001 09:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRLHOG5>; Sat, 8 Dec 2001 09:06:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17157 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S280674AbRLHOGo>;
	Sat, 8 Dec 2001 09:06:44 -0500
Date: Sat, 8 Dec 2001 15:06:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org, campbell@torque.net
Subject: Re: [PATCH][RFC] Allow drivers/scsi/imm.c to compile in 2.5.1pre6
Message-ID: <20011208140638.GB11567@suse.de>
In-Reply-To: <29EB5FE64EF@coral.indstate.edu> <20011208140227.GA11567@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011208140227.GA11567@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08 2001, Jens Axboe wrote:
> Two problems:
> 
> - detect() is not run with lock held anymore
> - use of ->address is deprecated

Actually a third one too that is also right in my patch but I neglected
to mention -- don't rely on using cmd->host _after_ having called
->scsi_done() on this command.

-- 
Jens Axboe

