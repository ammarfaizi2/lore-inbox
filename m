Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753789AbWKFU4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbWKFU4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbWKFU4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:56:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753789AbWKFU4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:56:20 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <454F9BB3.6020004@cosmosbay.com>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
	 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de>
	 <454F9BB3.6020004@cosmosbay.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 15:56:11 -0500
Message-Id: <1162846571.2618.0.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 21:31 +0100, Eric Dumazet wrote:
> > 
> > Also, do you have a testcase that can actually force the wrap?
> 
> while (1) {
> 	int fd[2];
> 	pipe(fd);
> 	close(fd[0]);
> 	close(fd[1]);
> }
> 

Yep, add an fstat(fd[0]) before the closes and you essentially have the
reproducer I was given for this.
-- Jeff


