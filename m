Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbTGORqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbTGORo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:44:28 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:62621 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269222AbTGORnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:43:18 -0400
Date: Tue, 15 Jul 2003 18:57:59 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Message-ID: <20030715175758.GC15505@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1058290204.3857.51.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:43:32PM +0100, James Simmons wrote:

 >    This still doesn't solve the issue with the input api. The input layer 
 > can be modular on many levels. Even if we force the input core to be built in 
 > this will not stop people from building the keyabord drivers as modules. 

That issue seems to have worked itself out now. I think someone already
munged the relevant Kconfig. It's been a while since l-k got a flood of
"I booted 2.5 and my keyboard doesn't work any more", whereas if you
look at all the "2.6test doesn't boot" bug reports of the last week,
and count how many of them were due to CONFIG_VT=n, you'll notice a much
bigger ratio.

 > Having PS/2 support always turned to Y will not also work since there are 
 > systems that use just USB. Their is a point where users will just have to 
 > read the README and follow directions. We can't make people do the right 
 > thing.
 >    Also doing this kind of thing only covers up broken framebuffer 
 > drivers. Unfortunetly its going to take me months to cleanup and make the 
 > fbdev drivers behave right. 

One bug at a time. With the CONFIG_EMBEDDED hack, yes it will 'hide'
this problem, but it'll likely be many months before embedded folks
start thinking of using 2.6 anyways.

		Dave

