Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265199AbSJWUCg>; Wed, 23 Oct 2002 16:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSJWUCg>; Wed, 23 Oct 2002 16:02:36 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:23823 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265199AbSJWUCf>; Wed, 23 Oct 2002 16:02:35 -0400
Date: Wed, 23 Oct 2002 21:08:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] CONFIG_TINY
Message-ID: <20021023210845.A23157@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
References: <20021023215117.A29134@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021023215117.A29134@jaquet.dk>; from rasmus@jaquet.dk on Wed, Oct 23, 2002 at 09:51:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 09:51:17PM +0200, Rasmus Andersen wrote:
> o SWAP and BLOCK_DEV as modules

modules won't work I guess :)  but allowing to disable them is a good
idea.  Not that swap depends on the block device code, though.

I have implemented CONFIG_SWAP for the uClinux patches, but there are
still some small bits missing to allow CONFIG_MMU && !CONFIG_SWAP

> o vfsmounts hash reduced to one page

Should be made smaller unconditionally, IMHO.

