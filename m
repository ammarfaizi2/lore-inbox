Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSDIVkS>; Tue, 9 Apr 2002 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSDIVkR>; Tue, 9 Apr 2002 17:40:17 -0400
Received: from granite.he.net ([216.218.226.66]:64783 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S311735AbSDIVkQ>;
	Tue, 9 Apr 2002 17:40:16 -0400
Date: Tue, 9 Apr 2002 14:40:14 -0700
From: Greg KH <greg@kroah.com>
To: Rob Hall <rob@compuplusonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7,8-pre2 and USB
Message-ID: <20020409144014.B25192@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Rob Hall <rob@compuplusonline.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020409143049.A25192@kroah.com> <BBENIHKKLAMLHIECFJEPIEPNCAAA.rob@compuplusonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 05:44:17PM -0400, Rob Hall wrote:
> I've tried both the OHCI and the OHCI-HCD drivers... But it's not getting
> that far... the core is what's locking the system up. I probably should have
> been more specific on that. If I load the USB core as a module after init
> fires off, then USB works fine... if I compile it into the kernel, the USB
> core locks the machine down right after detecting my PnP BIOS. It doesn't
> get far enough to put anything into the system log.

Ah, ok.  Haven't heard of this problem before.  The USB core doesn't 
touch any hardware, but only initializes a few things, and adds a filesystem
to the kernel if you've selected it as a option.

Does it also happen if you only build the USB core into the kernel, yet
leave the host controllers and other drivers as modules?

Have you selected any USB drivers to be compiled into the kernel?

Can you send me your .config?

thanks,

greg k-h
