Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTEIMep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTEIMep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:34:45 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:47885 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263234AbTEIMen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:34:43 -0400
Date: Fri, 9 May 2003 13:47:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509134719.A22735@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305090843_MC3-1-381B-B2E9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305090843_MC3-1-381B-B2E9@compuserve.com>; from 76306.1226@compuserve.com on Fri, May 09, 2003 at 08:41:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 08:41:13AM -0400, Chuck Ebbert wrote:
> Christoph Hellwig wrote:
> 
> > You can have multiple mountspoints with the same path, only
> > the topmost one will be seen by userland.
> 
>   What keeps users from opening files before the upper layer
> filesystems get mounted?

Nothing.  Why would we want to do such silly things?

> And how do you handle user-mountable
> media like CD-ROMS?

look at supermount for a stackable filesystem that does nothing but
dealing with such media :)  It also shows how the underlying fs
can be mounted without ever exposing it to userspace..
