Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264024AbUECVht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbUECVht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbUECVhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:37:48 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:4813 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S264024AbUECVho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:37:44 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Peter Zaitsev <peter@mysql.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ram Pai <linuxram@us.ibm.com>, nickpiggin@yahoo.com.au, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040503135719.423ded06.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1083620245.23042.107.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 14:37:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 13:57, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > > The place which needs attention is handle_ra_miss().  But first I'd like to
> > > reacquaint myself with the intent behind the lazy-readahead patch.  Was
> > > never happy with the complexity and special-cases which that introduced.
> > 
> > lazy-readahead has no role to play here.
> 

Andrew,

Could you please clarify how this things become to be dependent on
read-ahead at all.

At my understanding read-ahead it to catch sequential (or other) access
pattern and do some advance reading, so instead of 16K request we do
128K request, or something similar.

But how could read-ahead disabled end up in 16K request converted to
several sequential synchronous 4K requests ? 

It all looks pretty strange.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



