Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTDWBkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 21:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTDWBkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 21:40:41 -0400
Received: from granite.he.net ([216.218.226.66]:3600 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263926AbTDWBkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 21:40:40 -0400
Date: Tue, 22 Apr 2003 18:54:54 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       andmike@us.ibm.com
Subject: Re: [RFC] Device class rework [0/5]
Message-ID: <20030423015454.GA6298@kroah.com>
References: <20030422205545.GA4701@kroah.com> <172940000.1051059583@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172940000.1051059583@w-hlinder>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 05:59:43PM -0700, Hanna Linder wrote:
> --On Tuesday, April 22, 2003 01:55:45 PM -0700 Greg KH <greg@kroah.com> wrote:
> 
> > Here's a set of patches that rework the current class support in the
> > kernel today into something that works a bit better, and is simpler to
> > use.
> 
> I did a quick sanity test of these patches on a 2-way PIII.
> It built and booted fine for me. I don't have any devices that 
> span multiple classes but the patch hasnt changed any of my 
> existing /sys/class output.

Hm, are you sure you applied them and are using that kernel?  :)

/sys/class should look something like this:

$ tree /sys/class/
/sys/class/
|-- cpu
|   `-- cpu0
|       |-- device -> ../../../devices/sys/cpu0
|       `-- foo
|-- input
`-- tty
    |-- console0
    |   `-- dev
    |-- ptmx0
    |   `-- dev
    |-- pts0
    |   `-- dev
    |-- pts1
    |   `-- dev
    |-- pts2
    |   `-- dev
    |-- pts3
    |   `-- dev
    |-- pts4
    |   `-- dev
    |-- pts5
    |   `-- dev
    |-- pts6
    |   `-- dev
    |-- pts7
    |   `-- dev
    |-- pty0
    |   `-- dev
    |-- pty1
    |   `-- dev
... and so on...


thanks,

greg k-h
