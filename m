Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUGEBzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUGEBzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 21:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUGEBzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 21:55:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265898AbUGEBzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 21:55:44 -0400
Date: Mon, 5 Jul 2004 02:55:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-ID: <20040705015543.GX12308@parcelfarce.linux.theplanet.co.uk>
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040703202541.GA11398@infradead.org> <20040703133556.44b70d60.akpm@osdl.org> <20040703210407.GA11773@infradead.org> <20040703143558.5f2c06d6.akpm@osdl.org> <20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk> <20040704145542.4d1723f5.akpm@osdl.org> <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk> <40E8B3DB.5010402@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E8B3DB.5010402@tequila.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 10:50:19AM +0900, Clemens Schwaighofer wrote:
> Well perhaps I am on the wrong track but eg /proc/bus/usb/002/005 is my
> digital camera and unless its either world rw or owned by me (user) I
> can't get any pictures unless I make myself root.
> 
> So yes, I would want to have chown/chmod in procfs ...

... except that /proc/bus/usb/* is not in procfs.  BTW, it makes more sense
to change GID of the file in question and make it group-writable, adding the
users who are allowed to mess with it into the group.
