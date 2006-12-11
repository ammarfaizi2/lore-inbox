Return-Path: <linux-kernel-owner+w=401wt.eu-S1762687AbWLKJlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762687AbWLKJlA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762699AbWLKJlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:41:00 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:20196 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762687AbWLKJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:40:59 -0500
Message-ID: <457D27A2.2050309@tls.msk.ru>
Date: Mon, 11 Dec 2006 12:40:50 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211091335.GA4587@ftp.linux.org.uk>
In-Reply-To: <20061211091335.GA4587@ftp.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Mon, Dec 11, 2006 at 03:27:37AM -0500, Chuck Ebbert wrote:
>> Prevent oops when an app tries to create a pipe while pipefs
>> is not mounted.
[]
> That makes no sense at all.  pipe_mnt is not created by userland
> mount; it's created by init_pipe_fs() and we'd bloody better
> have it done before any applications get a chance to run.
> 
> Please, explain how the hell did you manage to get a perverted
> config where that is not true.  In the meanwhile the patch is
> NAKed.

See for example http://marc.theaimsgroup.com/?t=116510390600001&r=1&w=2

Thanks.

/mjt
