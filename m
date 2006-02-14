Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWBNRUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWBNRUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWBNRUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:20:39 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:393
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1422692AbWBNRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:20:38 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: Al Viro <viro@ftp.linux.org.uk>, Phillip Susi <psusi@cfl.rr.com>
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
Date: Tue, 14 Feb 2006 09:20:20 -0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200602132316.15992.jzb@aexorsyst.com> <43F1FA74.80607@cfl.rr.com> <20060214162458.GD27946@ftp.linux.org.uk>
In-Reply-To: <20060214162458.GD27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140920.20685.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 08:24, Al Viro wrote:
> On Tue, Feb 14, 2006 at 10:42:44AM -0500, Phillip Susi wrote:
> > This is expected behavior.  The kernel doesn't have a /dev at the time
> > it mounts the root fs so it has no idea what /dev/sda1 is.
>
> Incorrect.  Read init/do_mounts.c::name_to_dev_t().

Thanks for the info...Philip, you are correct, but for the wrong reason.  Al,
you hit it right on the head...

It is intentional behavior, but the reason is that
for name_to_dev_t() to work, CONFIG_SYSFS must be enabled...so there's
my connection to the CONFIG_* option that I suspected...

Thanks again...

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
     ###  Any similarity between my views and the truth is completely ###
     ###  coincidental, except that they are endorsed by NO ONE       ###

