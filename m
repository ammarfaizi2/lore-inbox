Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272312AbTHNQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTHNQkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:40:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5895 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272312AbTHNQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:40:12 -0400
Date: Thu, 14 Aug 2003 17:40:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
Message-ID: <20030814174008.D332@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <m1he4kzpiy.fsf@frodo.biederman.org> <20030814085442.A21232@infradead.org> <20030814090605.A25516@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030814090605.A25516@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Aug 14, 2003 at 09:06:05AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:06:05AM +0100, Russell King wrote:
> That's likely to remove the keyboard driver, and some people like
> to configure their box so that ctrl-alt-del halts the system, and
> a further ctrl-alt-del reboots the system once halted.

Several people have asked me how to set this up, so I'll give the info
here.

- change inittab to call shutdown with -h instead of -r
- telinit Q

I think there is a catch on x86 though - I think shutdown -h powers the
machine down rather than halting it.  The redhat initscripts seem to
need a /halt file to prevent poweroff.  Maybe calling /sbin/halt
instead of shutdown from the initscripts would work better in those
cases...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

