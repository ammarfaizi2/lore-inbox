Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUCOXYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUCOXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:24:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:38093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262846AbUCOXYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:24:17 -0500
Date: Mon, 15 Mar 2004 15:26:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Romanick <idr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: DRM reorganization
Message-Id: <20040315152621.43a5bcef.akpm@osdl.org>
In-Reply-To: <40562AEC.9080509@us.ibm.com>
References: <40562AEC.9080509@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick <idr@us.ibm.com> wrote:
>
> We're looking at reorganizing the way DRM drivers are maintained. 
> Currently, the DRM kernel code lives deep in a subdirectory of the DRI 
> tree (which is a partial copy of the XFree86 tree).  We plan to move it 
> "up" to its own module at the top level.  That should make it *much* 
> easier for people that want to do things with the DRM but don't want all 
> the rest of X (i.e., DRI w/DirectFB, etc.).
> 
> When we do this move, we're open to the possibility of reorganizing the 
> file structure.  What can we do to make it easier for kernel release 
> maintainers to merge changes into their trees?

- Make sure that the files in the main kernel distribution are up to date.

- Prepare a shell script which does all the relevant file moves, send to
  Linus, along with a diff which fixes up Kconfig and Makefiles.

- Start patching the files in their new locations.
