Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUBIKJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUBIKJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 05:09:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264459AbUBIKJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 05:09:41 -0500
Date: Mon, 9 Feb 2004 10:09:40 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk>
References: <c07c67$vrs$1@terminus.zytor.com> <c07i5r$ctq$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c07i5r$ctq$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 08:59:39AM +0000, Miquel van Smoorenburg wrote:
> In article <c07c67$vrs$1@terminus.zytor.com>,
> H. Peter Anvin <hpa@zytor.com> wrote:
> >Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
> >thinking of restructuring the pty system slightly to make it more
> >dynamic and to make use of the new larger dev_t, and I'd like to get
> >rid of the BSD ptys as part of the same patch.
> 
> bootlogd(8) which is used by Debian and Suse is started as the
> first thing at boottime. It needs a pty, and tries to use /dev/pts
> if it's there but falls back to BSD style pty's if /dev/pts isn't
> mounted - which will be the case 99% of the time.

So what's the problem with calling mount(2)?
