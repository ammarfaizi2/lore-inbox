Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVL0GvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVL0GvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 01:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVL0GvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 01:51:25 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:46730 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932249AbVL0GvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 01:51:24 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Phil Oester <kernel@linuxace.com>
Cc: Willy Tarreau <willy@w.ods.org>, gcoady@gmail.com,
       netfilter-devel@lists.netfilter.org, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.14.5
Date: Tue, 27 Dec 2005 17:51:43 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <roo1r1pmr5fkq9n67osj5vcsas8htos868@4ax.com>
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com> <20051227051729.GR15993@alpha.home.local> <3ok1r15khvs8gka6qhhvt3u302mafkkr2r@4ax.com> <20051227054519.GA14609@alpha.home.local> <20051227060714.GA1053@linuxace.com>
In-Reply-To: <20051227060714.GA1053@linuxace.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 22:07:14 -0800, Phil Oester <kernel@linuxace.com> wrote:

>On Tue, Dec 27, 2005 at 06:45:19AM +0100, Willy Tarreau wrote:
>> On Tue, Dec 27, 2005 at 04:42:00PM +1100, Grant Coady wrote:
>> > + iptables -A INPUT -p all --match state --state ESTABLISHED,RELATED -j ACCEPT
>> > iptables: No chain/target/match by that name
>> 
>> So it's not only the NEW state, it's every "--match state".
>
>Odd...works fine here
>
># uname -r
>2.6.14.5
># iptables -nL | grep state
>ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED 
>DROP       all  --  0.0.0.0/0            0.0.0.0/0           state INVALID 
>logdrop    tcp  --  0.0.0.0/0            0.0.0.0/0           tcp flags:!0x17/0x02 state NEW 
>ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED 
>DROP       all  --  0.0.0.0/0            0.0.0.0/0           state INVALID 

Oops, my apologies to all, just rebuilt kernel again (third time) 
from scratch, using the working .config from 2.6.14.4 -- I do not 
know how I muffed the .config twice in a row on one box without 
stuffing up the seven other boxen I built/tested 2.6.14.5 on :(

Can copying a working 2.6.15-rc7 .config to 2.6.14.5, then make 
oldconfig do this?

Grant.
