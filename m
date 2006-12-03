Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758818AbWLCXMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbWLCXMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLCXMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:12:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:19173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1758818AbWLCXMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:12:09 -0500
X-Authenticated: #5039886
Date: Mon, 4 Dec 2006 00:12:06 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Device naming randomness (udev?)
Message-ID: <20061203231206.GA4413@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <45735230.7030504@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45735230.7030504@mbligh.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.12.03 14:39:44 -0800, Martin J. Bligh wrote:
> This PC has 1 ethernet interface, an e1000. Ubuntu Dapper.
> 
> On 2.6.14, my e1000 interface appears as eth0.
> On 2.6.15 to 2.6.18, my e1000 interface appears as eth1.
> 
> In both cases, there are no other ethX interfaces listed in
> "ifconfig -a". There are no modules involved, just a static
> kernel build.
> 
> Is this a bug in udev, or the kernel? I'm presuming udev,
> but seems odd it changes over a kernel release boundary.
> Any ideas on how I get rid of it? Makes automatic switching
> between kernel versions a royal pain in the ass.

Just a wild guess here... Debian's (and I guess Ubuntu's) udev rules
contain a generator for persistent interface name rules. Maybe these
start working with 2.6.15 and thus the switch (ie. the kernel would call
it eth0, but udev renames it to eth1).
The generated rules are written to
/etc/udev/rules.d/z25_persistent-net.rules on Debian, not sure if its
the same for Ubuntu. Editing/removing the rules should fix your problem.

HTH
Björn
