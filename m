Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVKESoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVKESoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKESoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:44:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45184 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932196AbVKESoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:44:09 -0500
Date: Sat, 5 Nov 2005 18:44:08 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Message-ID: <20051105184408.GO7992@ftp.linux.org.uk>
References: <20051105182728.GB27767@apogee.jonmasters.org> <20051105103358.2e61687f.akpm@osdl.org> <20051105184028.GD27767@apogee.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105184028.GD27767@apogee.jonmasters.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 06:40:28PM +0000, Jon Masters wrote:
> And as I said, the situation as it stands leads to potential data
> corruption but I agree with you - we need a VFS callback to handle
> readwrite/readonly change on remount I think. Comments?

It's not that simple.  Filesystem side of ro/rw transitions is
messy as hell and no, "VFS callback" won't be enough.
