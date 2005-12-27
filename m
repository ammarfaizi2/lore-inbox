Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVL0GHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVL0GHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 01:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVL0GHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 01:07:16 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:24479
	"HELO linuxace.com") by vger.kernel.org with SMTP id S932245AbVL0GHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 01:07:15 -0500
Date: Mon, 26 Dec 2005 22:07:14 -0800
From: Phil Oester <kernel@linuxace.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: gcoady@gmail.com, netfilter-devel@lists.netfilter.org,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.14.5
Message-ID: <20051227060714.GA1053@linuxace.com>
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com> <20051227051729.GR15993@alpha.home.local> <3ok1r15khvs8gka6qhhvt3u302mafkkr2r@4ax.com> <20051227054519.GA14609@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227054519.GA14609@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 06:45:19AM +0100, Willy Tarreau wrote:
> On Tue, Dec 27, 2005 at 04:42:00PM +1100, Grant Coady wrote:
> > + iptables -A INPUT -p all --match state --state ESTABLISHED,RELATED -j ACCEPT
> > iptables: No chain/target/match by that name
> 
> So it's not only the NEW state, it's every "--match state".

Odd...works fine here

# uname -r
2.6.14.5
# iptables -nL | grep state
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED 
DROP       all  --  0.0.0.0/0            0.0.0.0/0           state INVALID 
logdrop    tcp  --  0.0.0.0/0            0.0.0.0/0           tcp flags:!0x17/0x02 state NEW 
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED 
DROP       all  --  0.0.0.0/0            0.0.0.0/0           state INVALID 

Phil
