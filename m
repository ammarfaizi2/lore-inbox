Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSFGWzi>; Fri, 7 Jun 2002 18:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSFGWzh>; Fri, 7 Jun 2002 18:55:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17845 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317351AbSFGWzg>; Fri, 7 Jun 2002 18:55:36 -0400
Date: Fri, 7 Jun 2002 15:55:31 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Shane Walton <dsrelist@yahoo.com>, gibbs@scsiguy.com
Subject: Re: Stream Lined Booting - SCSI Hold Up
Message-ID: <20020607155531.A13335@eng2.beaverton.ibm.com>
In-Reply-To: <20020605172240.17081.qmail@web20808.mail.yahoo.com> <20020606134419.A24456@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 01:44:19PM -0700, Patrick Mansfield wrote:

> On my system, it saves me about 10 seconds to boot with:
> 
> lilo: linux-1 aic7xxx=no_reset aic7xxx=seltime:3
> 

BTW, the above results in an infinite loop on shutdown, as the aic
driver adds a reboot callback for each "aic7xxx=" option, pointing
to static data, and ends up getting linked on a list pointing to
itself. Using:

	aic7xxx=no_reset,seltime:3

I have no problems.

-- Patrick Mansfield
