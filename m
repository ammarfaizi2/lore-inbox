Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVL0F6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVL0F6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVL0F6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:58:50 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:25989 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932238AbVL0F6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:58:49 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: gcoady@gmail.com, Willy Tarreau <willy@w.ods.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: Linux 2.6.14.5
Date: Tue, 27 Dec 2005 16:59:08 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <kll1r1pki4nn0utp5c4gtf0qkmdnhqjut0@4ax.com>
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com> <20051227051729.GR15993@alpha.home.local> <3ok1r15khvs8gka6qhhvt3u302mafkkr2r@4ax.com> <20051227054519.GA14609@alpha.home.local>
In-Reply-To: <20051227054519.GA14609@alpha.home.local>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005 06:45:19 +0100, Willy Tarreau <willy@w.ods.org> wrote:

>On Tue, Dec 27, 2005 at 04:42:00PM +1100, Grant Coady wrote:
>> On Tue, 27 Dec 2005 06:17:29 +0100, Willy Tarreau <willy@w.ods.org> wrote:
>> 
>> >On Tue, Dec 27, 2005 at 02:06:03PM +1100, Grant Coady wrote:
>> >> On Mon, 26 Dec 2005 16:53:27 -0800, Greg KH <gregkh@suse.de> wrote:
>> >> 
>> >> >We (the -stable team) are announcing the release of the 2.6.14.5 kernel.
>> >> >
>> >> >The diffstat and short summary of the fixes are below.
>> >> >
>> >> >I'll also be replying to this message with a copy of the patch between
>> >> >2.6.14.4 and 2.6.14.5, as it is small enough to do so.
>> >> 
>> >> netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
>> >> on this box) or 2.4.32 :(  Same ruleset as used for months.
>> >> 
>> >> Fails to recognise named chains with a useless error message:
>> >> 
>> >> "iptables: No chain/target/match by that name"
>> >
>> >Grant, please put a "set -x" at the top of your script so that you
>> >can tell what rule causes this error.
>> 
>> + iptables -A INPUT -p all --match state --state ESTABLISHED,RELATED -j ACCEPT
>> iptables: No chain/target/match by that name
>
>So it's not only the NEW state, it's every "--match state".

Yep, hard evidence vs the early eyeball check (vs the wrong 
first impression :o)

Grant.
