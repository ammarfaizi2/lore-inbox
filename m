Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTKXSQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKXSQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:16:42 -0500
Received: from hosting-agency.de ([195.69.240.23]:35801 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S262425AbTKXSQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:16:41 -0500
From: Jakob Lell <jlell@JakobLell.de>
To: splite@purdue.edu
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 19:18:56 +0100
User-Agent: KMail/1.5.4
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <200311241857.41324.jlell@JakobLell.de> <20031124180838.GA8065@sigint.cs.purdue.edu>
In-Reply-To: <20031124180838.GA8065@sigint.cs.purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311241918.56486.jlell@JakobLell.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 November 2003 19:08, splite@purdue.edu wrote:
> On Mon, Nov 24, 2003 at 06:57:41PM +0100, Jakob Lell wrote:
> > [...]
> > Setuid-root binaries also work in a home directory.
> > You can try it by doing this test:
> > ln /bin/ping $HOME/ping
> > $HOME/ping localhost
> > [...]
>
> That's why you don't put user-writable directories on the root or /usr
> partitions.  (For extra points, mount your /tmp and /var/tmp partitions
> nodev,nosuid.)  Seriously guys, this is Unix Admin 101, not a major new
> security problem.
Even if you put /usr on a separate partition, users can create a setuid (not 
setuid-root) program in their home directory. Other users can create links to 
this program in their home directory. Even if this can't be used to become 
root, it shouldn't be possible. To prevent this, you have to put every user's 
home directory on a separate partition.

