Return-Path: <linux-kernel-owner+w=401wt.eu-S1762656AbWLKJNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762656AbWLKJNh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762672AbWLKJNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:13:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49417 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762656AbWLKJNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:13:36 -0500
Date: Mon, 11 Dec 2006 09:13:35 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211091335.GA4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 03:27:37AM -0500, Chuck Ebbert wrote:
> Prevent oops when an app tries to create a pipe while pipefs
> is not mounted.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

That makes no sense at all.  pipe_mnt is not created by userland
mount; it's created by init_pipe_fs() and we'd bloody better
have it done before any applications get a chance to run.

Please, explain how the hell did you manage to get a perverted
config where that is not true.  In the meanwhile the patch is
NAKed.
