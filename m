Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTKVKQC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 05:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTKVKQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 05:16:02 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:45069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262133AbTKVKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 05:16:01 -0500
Date: Sat, 22 Nov 2003 10:15:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Juergen Hasch <lkml@elbonia.de>
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
Subject: Re: Using get_cwd inside a module.
Message-ID: <20031122101559.A30932@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Juergen Hasch <lkml@elbonia.de>,
	Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com> <20031122083035.A30106@infradead.org> <200311221033.35108.lkml@elbonia.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311221033.35108.lkml@elbonia.de>; from lkml@elbonia.de on Sat, Nov 22, 2003 at 10:33:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 10:33:34AM +0100, Juergen Hasch wrote:
> Am Samstag, 22. November 2003 09:30 schrieb Christoph Hellwig:
> > The basic problem is that you shouldn't call syscalls from kernelspace.
> > Have you looked at dnotify to look for changed files instead?
> 
> Dnotify doesn't return the file names that changed, changedfiles does.
> I've looked into this, because Samba would benefit from such a functionality.
> 
> So maybe it would be possible to teach dnotify to return file names
> (e.g. using netlink) ?

Well, you can't return filenames.  There's no unique path to a give
file. 

What are the exact requirements of changedfiles or samba?
