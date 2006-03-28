Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWC1OOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWC1OOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWC1OOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:14:45 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:27361 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932264AbWC1OOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:14:44 -0500
Date: Tue, 28 Mar 2006 16:14:43 +0200
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-ID: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de>
Mail-Followup-To: Pete Clements <clem@clem.clem-digital.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200603270212.k2R2CUki003654@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603270212.k2R2CUki003654@clem.clem-digital.net>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.1 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: aa86db5e7f3e85aa9355d5c307b12c26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 09:12:30PM -0500, Pete Clements wrote:
> Reported this earlier as a 3c509 card in error, should
> have been 3c900 (3c59x driver).
> 
> FYI:
>   Single 3c900 card, UP i386
>   Lost networking with .16-git12, message
>   ADDRCONF(NETDEV_UP): eth0: link is not ready

This could be due to the recent driver update.
I can not reproduce this with a 3c900B-Combo,
so I need some more information to track it down.

>   Had several of these with git11
>   NETDEV WATCHDOG: eth0: transmit timed out

Is this for sure that these messages occured first time with git11?
There were no changes in the 3c59x driver between git10 and git11.

> 
>   No problems observed git1-git10
> 

If you are willing to provide me with some information
you can send the following:

1. output of lspci -vvv (just the ethernet controller related part)

2. your Kernel configuration

3. modprobe the driver with debug=4 and send
the 3c59x related lines of your logs for both, git11 and git12.
(From driver startup about 15 seconds should be sufficiant for now)

4. the output of "vortex-diag -aem" and "mii-diag".
You can find these tools at http://www.scyld.com/ethercard_diag.html


Steffen
