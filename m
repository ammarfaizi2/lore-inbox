Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUB0Sbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbUB0Sbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:31:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:43216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262916AbUB0SaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:30:12 -0500
Date: Fri, 27 Feb 2004 10:30:03 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sysfs is too restrictive
Message-Id: <20040227103003.4832cbf0@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040227181454.GD15016@redhat.com>
References: <20040227100541.284fb155@dell_ss3.pdx.osdl.net>
	<20040227181454.GD15016@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 18:14:55 +0000
Dave Jones <davej@redhat.com> wrote:

> On Fri, Feb 27, 2004 at 10:05:41AM -0800, Stephen Hemminger wrote:
>  >     |   |-- bridge
>  >     |   |   |-- forward_delay
>  >     |   |   |-- hello_time
>  >     |   |   |-- id
>  >     |   |   |-- max_age
>  >     |   |   |-- port
>  >     |   |   |   |-- cost
>  >     |   |   |   |-- eth0 -> ../../../eth0
>  >     |   |   |   |-- priority
>  >     |   |   |   `-- stp
>  >     |   |   `-- priority
>  >     |   |-- broadcast
> 
> Shouldn't you be seeing the other side of the bridge in here too ?
> Ie, if br0 is a bridge between eth0 and eth1, how does that fit
> your plan ?

yes, there would be multiple interfaces in the port directory.
More like this:

br0
`-- bridge
    |-- forward_delay
    |-- id
    |-- max_age
    |-- port
    |   |-- eth0
    |   |   |-- cost
    |   |   |-- interface -> ../../../../eth0
    |   |   |-- priority
    |   |   `-- stp
    |   `-- eth1
    |   |   |-- cost
    |   |   |-- interface -> ../../../../eth1
    |   |   |-- priority
    |   |   `-- stp
    `-- priority

4 directories, 8 files

