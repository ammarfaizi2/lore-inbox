Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVA1VeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVA1VeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVA1VeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:34:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:43200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262747AbVA1VeD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:34:03 -0500
Date: Fri, 28 Jan 2005 13:34:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Lorenzo =?ISO-8859-1?B?SGVybuFuZGV6IEdhcmPtYS1IaWVycm8=?= 
	<lorenzo@gnu.org>,
       linux-kernel@vger.kernel.org, chrisw@osdl.org, netdev@oss.sgi.com,
       arjan@infradead.org, hlein@progressive-comp.com
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050128133408.49021343@dxpl.pdx.osdl.net>
In-Reply-To: <20050128124517.36aa5e05.davem@davemloft.net>
References: <1106932637.3778.92.camel@localhost.localdomain>
	<20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	<1106937110.3864.5.camel@localhost.localdomain>
	<20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	<1106944492.3864.30.camel@localhost.localdomain>
	<20050128124517.36aa5e05.davem@davemloft.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 12:45:17 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> On Fri, 28 Jan 2005 21:34:52 +0100
> Lorenzo Hernández García-Hierro <lorenzo@gnu.org> wrote:
> 
> > Attached the new patch following Arjan's recommendations.
> 
> No SMP protection on the SBOX, better look into that.
> The locking you'll likely need to add will make this
> routine serialize many networking operations which is
> one thing we've been trying to avoid.
> 

per-cpu would be the way to go here.

-- 
Stephen Hemminger	<shemminger@osdl.org>
