Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbREMT2C>; Sun, 13 May 2001 15:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbREMT1x>; Sun, 13 May 2001 15:27:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6183 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261464AbREMT1m>; Sun, 13 May 2001 15:27:42 -0400
To: "H . J . Lu" <hjl@lucon.org>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2001 13:24:18 -0600
In-Reply-To: "H . J . Lu"'s message of "Sun, 13 May 2001 11:07:07 -0700"
Message-ID: <m1y9s1jbml.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" <hjl@lucon.org> writes:

> It doesn't make any senses. When I specify CONFIG_IP_PNP and
> BOOTP/DHCP, I want a kernel with IP config using BOOTP/DHCP. I would
> expect IP config is turned for BOOTP/DHCP by default. You can turn
> it off by passing "ip=off" to kernel. Did I miss something?

Since you have to set the command line anyway ip=dhcp is no extra
burden and it lets you use the same kernel to boot of the harddrive etc.

> > This same situation exists for 2.2.18 & 2.2.19 as well.
> > 
> > The only way to get long term stability out of this is to write
> > a user space client, you can put in a ramdisk.  One of these days...
> 
> It doesn't work with diskless machines which don't support ramdisk
> during boot.

I don't believe that is a real world situation.

I boot diskless all of time and supporting a ramdisk is trivial.  You
just a have a program that slaps a kernel a ramdisk, and some command
line arguments into a single image, along with a touch of adapter code
to set the kernel parameters correctly and then boot that.

Eric
