Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbULGExH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbULGExH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 23:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbULGExG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 23:53:06 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:35456
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261753AbULGExD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 23:53:03 -0500
Date: Mon, 6 Dec 2004 20:53:02 -0800
From: Phil Oester <kernel@linuxace.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: shemminger@osdl.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Recent select() handling change breaks Poptop
Message-ID: <20041207045302.GA23746@linuxace.com>
References: <20041207003525.GA22933@linuxace.com> <20041207025218.GB61527@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207025218.GB61527@gaz.sfgoth.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 06:52:18PM -0800, Mitchell Blank Jr wrote:
> That's very strange.  It would be helpful if you could gather:
>   1. strace of the server, both working and broken

Will work on it

>   2. a "tcpdump -nvv" of its udp traffic (ideally captured from a seperate
>      server, but from the server would probably be OK too)

PPTP uses TCP 1723 and GRE (proto 47), so there is no udp traffic involved.
I suspect the change was made to all datagram traffic with the assumption 
that UDP was the only protocol impacted.  Perhaps GRE was not considered?

Phil
