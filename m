Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbTCZSmR>; Wed, 26 Mar 2003 13:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbTCZSmR>; Wed, 26 Mar 2003 13:42:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56325 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261866AbTCZSmQ>;
	Wed, 26 Mar 2003 13:42:16 -0500
Date: Wed, 26 Mar 2003 10:52:36 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030326185236.GE24689@kroah.com>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326162538.GG2695@spackhandychoptubes.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 04:25:38PM +0000, Chris Sykes wrote:
> However it is easy to cause the BUG by simply:
> 
> bash # echo "Some string" >/dev/ttyUSB0

The oops happens on close(), right?  To verify this try:
	cat /dev/ttyUSB0
no oops should happen until you interrupt this.

Anyway, this is a known usb-serial bug right now.  It should be fixed in
the 2.5 tree, but I haven't had enough people test that code out to know
if this is really true (I can't duplicate the bug on 2.4 myself.)

Can you test 2.5 to see if this is fixed there for you or not?

thanks,

greg k-h
