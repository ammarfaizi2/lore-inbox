Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbTICGf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTICGf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:35:26 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28427 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263707AbTICGfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:35:23 -0400
Date: Wed, 3 Sep 2003 07:35:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       hch@infradead.org, akpm@osdl.org
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030903073522.A30542@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
References: <1062557567.846.2090.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062557567.846.2090.camel@cube>; from albert@users.sf.net on Tue, Sep 02, 2003 at 10:52:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:52:47PM -0400, Albert Cahalan wrote:
> The problem may be more serious. There are lots of
> apps that use the old-style PTYs w/o any libc help.

That's not a problem, just bad design.  It continues to work as always,
i.e. you don't get an automic chown.  For that you either needs the
libc interface with the pt_chown helper of UNIX98 ptys.

