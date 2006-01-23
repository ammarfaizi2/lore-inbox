Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWAWFcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWAWFcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWAWFcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:32:31 -0500
Received: from free.wgops.com ([69.51.116.66]:51984 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S964796AbWAWFc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:32:29 -0500
Date: Sun, 22 Jan 2006 22:32:12 -0700
From: Michael Loftis <mloftis@wgops.com>
To: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <B78EFD916FFE8034EC546F38@dhcp-2-206.wgops.com>
In-Reply-To: <43D3295E.8040702@comcast.net>
References: <43D3295E.8040702@comcast.net>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 22, 2006 1:42:38 AM -0500 John Richard Moser 
<nigelenki@comcast.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> So I've been researching, because I thought this "Soft Update" thing
> that BSD uses was some weird freak-ass way to totally corrupt a file
> system if the power drops.  Seems I was wrong; it's actually just the
> opposite, an alternate solution to journaling.  So let's compare notes.

I hate to say it...but in my experience, this has been exactly the case 
with soft updates and FreeBSD 4 up to 4.11 pre releases.

Whenever something untoward would happen, the filesystem almost always lost 
files and/or data, usually just files though.  In practice it's never 
really worked too well for me.  It also still requires a full fsck on boot, 
which means long boot times for recovery on large filesystems.
