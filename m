Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTFPSiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTFPSiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:38:06 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:11501
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S264173AbTFPSfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:35:42 -0400
Date: Sun, 15 Jun 2003 20:59:38 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Peter Enderborg <pme@hyglo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmware strange scheduling priority
Message-ID: <20030615185938.GA7689@wind.cocodriloo.com>
References: <3EEE0EEA.9080208@hyglo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEE0EEA.9080208@hyglo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 08:39:38PM +0200, Peter Enderborg wrote:
> Im playing with vmware 4.0 workstation. And it do some strange 
> things.
> I start vmware with nice and I got this:
> 26499 pme       19  19 95980  93M 95020 R N    12 32.6 24.8   8:55 
> vmware-vmx
> 26439 pme       19  19  8416 8008  7692 R N     8  3.2  2.0   2:02 
> vmware-vmx
> 26492 pme        6 -10 95980  93M 95020 R <    12  2.6 24.8   0:34 
> vmware-vmx
> 26409 pme       19  19  4900 3916  2484 S N     0  1.0  1.0   0:29 
> vmware
> 26433 pme        5 -10  8416 8008  7692 S <     8  0.5  2.0   0:29 
> vmware-vmx
> 26493 pme        5 -10  8056 7268  6988 S <     0  0.5  1.8   0:20 
> vmware-mks
> 26495 pme        9   0 67672  65M 66888 S       0  0.2 17.4   0:11 
> vmware-vmx
> 
> 
> It have changed the prioority to -10 for some of its own tasks. How 
> can that be done? Its a non suid binary started
> by a normal user. It's very ugly, but Im more intressted in how it 
> can be done.
> The kernel is a 2.4.20.

pure guessing here...
vmware relies on having kernel modules instaled.. perhaps
the do an ioctl to enter the module and then they spin
off some threads with nice -10 from inside?
 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
winden/network

In fact, this is all you need to know to be
a Caveman Database Programmer:

A relational database is a big spreadsheet
that several people can update simultaneously. 

