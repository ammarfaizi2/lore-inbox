Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbUAFEae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUAFEae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:30:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37021 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265699AbUAFEad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:30:33 -0500
Date: Tue, 6 Jan 2004 04:30:31 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
Message-ID: <20040106043031.GJ4176@parcelfarce.linux.theplanet.co.uk>
References: <3FFA30FA.1040602@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA30FA.1040602@conet.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 04:52:26AM +0100, Libor Vanek wrote:
> MY TINY MODIFICATION:
> ...
> asmlinkage long sys_open(const char __user * filename, int flags, int mode)
> {
>        char * tmp;
>        int fd, error;
> 	char tmp_path[PATH_MAX],tmp2_path[PATH_MAX];

You "TINY" modification had just allocated more than entire stack size.
On stack.
