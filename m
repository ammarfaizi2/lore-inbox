Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTFXOkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTFXOkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:40:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262177AbTFXOkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:40:10 -0400
Date: Tue, 24 Jun 2003 15:54:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.72: follow_mount / follow_link
Message-ID: <20030624145418.GP6754@parcelfarce.linux.theplanet.co.uk>
References: <3EF86337.1020103@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF86337.1020103@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 10:41:59AM -0400, Mike Waychison wrote:

> The changes made in fs/namei.c@1.42 break this behaviour iff the dentry 
> being follow_link'ed is a root dentry.  This is becauseo

... mixing symlinks and mounting is ripe with very ugly races and corner
cases.  Not allowed - symlink can't be a mountpoint or a mounted object.
