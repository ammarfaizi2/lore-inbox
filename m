Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTKZMub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 07:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTKZMub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 07:50:31 -0500
Received: from holomorphy.com ([199.26.172.102]:32189 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261885AbTKZMua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 07:50:30 -0500
Date: Wed, 26 Nov 2003 04:50:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PG_reserved bug
Message-ID: <20031126125020.GL8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
References: <20031126101744.GJ8039@holomorphy.com> <003e01c3b41b$22140580$1d01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003e01c3b41b$22140580$1d01a8c0@CARTMAN>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 02:45:06PM +0200, Amir Hermelin wrote:
> Ok, fair enough.  According to what you say, this behavior won't change in
> 2.6.  So, I'm still left with my second question: since I do access the
> pages from several places in my module, and I want to use the refcount field
> of the struct page (and not have to wrap the pages in another structure) so
> I know when my page is no longer referenced, how can I make sure it's 'safe'
> to not use the reserved bit?

It looks like you'll have to wrap the pages in another structure.
The refcounts for reserved pages are effectively meaningless.


-- wli
