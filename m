Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbTF2N4s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbTF2N4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:56:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62605 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265680AbTF2N4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:56:46 -0400
Date: Sun, 29 Jun 2003 15:11:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH-2.4] Prevent mounting on ".."
Message-ID: <20030629141102.GE27348@parcelfarce.linux.theplanet.co.uk>
References: <20030629130952.GA246@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629130952.GA246@pcw.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 03:09:52PM +0200, Willy TARREAU wrote:
> chroot("/var/empty") (read-only directory or file-system)
> chdir("/")
> listen(), accept(), fork(), whatever...
> -> external code injection from a cracker :
>    mount("none", "..", "ramfs")
>    mkdir("../mydir")
>    chdir("../mydir")
>    the cracker now installs whatever he wants here.

That's a BS.  Same effect would be achieved by replacing ".." with ".".
Or mounting on any existing subdirectory.

If attacker can mount of chroot - you've LOST.  Already.  End of story.
