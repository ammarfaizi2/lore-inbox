Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753211AbWKGUlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbWKGUlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKGUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:41:42 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:3259 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1752501AbWKGUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:41:41 -0500
Date: Tue, 7 Nov 2006 21:41:35 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107204135.GF29746@wohnheim.fh-wedel.de>
References: <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <20061107174217.GA29746@wohnheim.fh-wedel.de> <20061107175601.GB29746@wohnheim.fh-wedel.de> <1162928464.28425.59.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1162928464.28425.59.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 November 2006 14:41:04 -0500, Jeff Layton wrote:
> 
>   How about this patch instead here? I don't think anything depends on
> i_ino being any certain value for these files, and this seems less
> "magic-numbery". This should also mostly prevent us from assigning out
> i_ino=0.

nfsctl_transaction_write() appears to depend on i_ino.

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
