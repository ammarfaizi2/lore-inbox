Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317724AbSFSB16>; Tue, 18 Jun 2002 21:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317725AbSFSB15>; Tue, 18 Jun 2002 21:27:57 -0400
Received: from smtp.comcast.net ([24.153.64.2]:41592 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S317724AbSFSB14>;
	Tue, 18 Jun 2002 21:27:56 -0400
Date: Tue, 18 Jun 2002 21:27:52 -0400
From: Tom Vier <tmv@comcast.net>
Subject: Re: VMM - freeing up swap space
In-reply-to: <Pine.LNX.4.21.0206181903550.1374-100000@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20020619012752.GA7157@zero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <Pine.LNX.3.95.1020618125355.5056A-100000@chaos.analogic.com>
 <Pine.LNX.4.21.0206181903550.1374-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 07:17:00PM +0100, Hugh Dickins wrote:
> In what forum, by the way, may I suggest to distros that they "rm -rf"
> in any tmpfs mounts before shutdown swapoff?  It avoids this OOM issue
> at shutdown, plus it's a whole lot faster than doing the swapoff.

actually, debian testing's /etc/init.d/umountfs umounts tmpfs before
swapoff. tmpfs contents are freed on umount, so there's no need for rm -rf
(it would be slower, anyway).

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
