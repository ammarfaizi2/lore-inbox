Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbTCZLXv>; Wed, 26 Mar 2003 06:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbTCZLXv>; Wed, 26 Mar 2003 06:23:51 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:47122 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261610AbTCZLXu>; Wed, 26 Mar 2003 06:23:50 -0500
Date: Wed, 26 Mar 2003 11:34:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: corryk@us.ibm.com, linux-kernel@vger.kernel.org,
       joe@fib011235813.fsnet.co.uk, lvm-devel@sistina.com
Subject: Re: struct dm_ioctl
Message-ID: <20030326113456.A15611@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, corryk@us.ibm.com,
	linux-kernel@vger.kernel.org, joe@fib011235813.fsnet.co.uk,
	lvm-devel@sistina.com
References: <UTC200303261127.h2QBRTt05048.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303261127.h2QBRTt05048.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Mar 26, 2003 at 12:27:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 12:27:29PM +0100, Andries.Brouwer@cwi.nl wrote:
> One is struct dm_ioctl. Google tells me that it was
> noticed already that it defined a broken interface,
> and Kevin Corry submitted a patch against 2.5.51.
> Today this has not been applied yet.
> 
> What is the status? Should I resubmit that patch?

DM already has a pathname-based interface.  Just rip out the dev_t-
based one, this will also allow to simplify the kernel code by using
the pathname to fully setuped blockdevice helpers I added to block_dev.c

