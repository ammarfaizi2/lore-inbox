Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTKXSWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKXSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:22:40 -0500
Received: from hosting-agency.de ([195.69.240.23]:10720 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S263771AbTKXSWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:22:36 -0500
From: Jakob Lell <jlell@JakobLell.de>
To: root@chaos.analogic.com, splite@purdue.edu
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 19:24:51 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <20031124180838.GA8065@sigint.cs.purdue.edu> <Pine.LNX.4.53.0311241312180.18685@chaos>
In-Reply-To: <Pine.LNX.4.53.0311241312180.18685@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200311241924.51016.jlell@JakobLell.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 November 2003 19:13, Richard B. Johnson wrote:
> On Mon, 24 Nov 2003 splite@purdue.edu wrote:
> > On Mon, Nov 24, 2003 at 06:57:41PM +0100, Jakob Lell wrote:
> > > [...]
> > > Setuid-root binaries also work in a home directory.
> > > You can try it by doing this test:
> > > ln /bin/ping $HOME/ping
> > > $HOME/ping localhost
> > > [...]
> >
> > That's why you don't put user-writable directories on the root or /usr
> > partitions.  (For extra points, mount your /tmp and /var/tmp partitions
> > nodev,nosuid.)  Seriously guys, this is Unix Admin 101, not a major new
> > security problem.
>
> And if the inode that was referenced in the root-owned directory
> was deleted, it would no longer function as setuid root.
Hello,
I've just checked it out. It still works as setuid root. Just try this (as 
root):
cp /bin/ping /tmp/ping
chmod 4755 /tmp/ping
su user
ln /tmp/ping $HOME/ping
exit
rm /tmp/ping
su user
$HOME/ping localhost
rm $HOME/ping

Regards
 Jakob

