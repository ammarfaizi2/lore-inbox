Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSE2UJX>; Wed, 29 May 2002 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSE2UJW>; Wed, 29 May 2002 16:09:22 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:44562 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S315457AbSE2UJV>; Wed, 29 May 2002 16:09:21 -0400
Date: Wed, 29 May 2002 21:09:10 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: "Christian.Gennerat" <xgen@noos.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel zombie threads after module removal.
Message-ID: <20020529200908.GA7499@compsoc.man.ac.uk>
In-Reply-To: <3CF52841.8040507@noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *17D9ky-0000Lq-00*Nz6GTfNyOBo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 09:13:05PM +0200, Christian.Gennerat wrote:

> This is very close to the problem related in 
> http://lkml.org/archive/2002/2/4/368/index.html
> but I have no USB. I have SCSI with aha152x_cs.o,
> and after doing "cardctl eject" that removes the module,
> the process scsi_eh_0  stays as zombie.

Add 

	reparent_to_init();

after the call to daemonize() in scsi_error_handler() in
drivers/scsi/scsi_error.c

Disclaimer: I don't know this code at all

regards
john

-- 
"If you look 'round the table and can't tell who the sucker is, it's you." 
	- Quiz Show 
