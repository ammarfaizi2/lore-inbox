Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269890AbUIDLMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269890AbUIDLMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269882AbUIDLMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:12:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7174 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269886AbUIDLL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:11:27 -0400
Date: Sat, 4 Sep 2004 12:11:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4][diskdump] x86-64 support
Message-ID: <20040904121122.C14123@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <20040828112324.B8000@infradead.org> <9AC48F3A62CFC4indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9AC48F3A62CFC4indou.takao@soft.fujitsu.com>; from indou.takao@soft.fujitsu.com on Tue, Aug 31, 2004 at 06:10:40PM +0900
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 06:10:40PM +0900, Takao Indoh wrote:
> >a spin_trylock would be safe.  hd can't be NULL.
> 
> Could you explain to me why spin_is_locked is not safe?

it's inherently racy.  Also it's always return 0 on UP systems which
makes it totally useless there.

