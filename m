Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161470AbWBUKjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbWBUKjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWBUKjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:39:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42625 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161470AbWBUKju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:39:50 -0500
Date: Tue, 21 Feb 2006 10:39:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060221103949.GD19349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060220221948.GC5733@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220221948.GC5733@linuxhacker.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 12:19:48AM +0200, Oleg Drokin wrote:
> Hello!
> 
>    We are working on a lustre client that would not require any patches
>    to linux kernel. And there are few things that would be nice to have
>    that I'd like your input on.
> 
>    One of those is FMODE_EXEC - to correctly detect cross-node situations with
>    executing a file that is opened for write or the other way around, we need
>    something like this extra file mode to be present (and used as a file open
>    mode when opening files for exection, e.g. in fs/exec.c)
>    Do you think there is a chance this can be included into vanilla kernel,
>    or is there a better solution I oversee?
>    I am just thinking about something as simple as this
>    (with some suitable FMODE_EXEC define, of course):

The patch looks fine to me.  We can put it in once we'll put in the
full lustre client.

