Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271017AbTGPSJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270977AbTGPSHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:07:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28363
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271017AbTGPSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:05:48 -0400
Subject: Re: Trivial Change (E820map) : arch/i386/boot/setup.S
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Romit Dasgupta <romit@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F158C5F.1000300@myrealbox.com>
References: <3F158C5F.1000300@myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058379483.6600.47.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 19:18:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 18:33, Romit Dasgupta wrote:
> Hi,
>       After reading the e820 method from Ralf Brown's interrupt list(
> http://www.ctyme.com/intr/rb-1741.htm)
> it seems that the es register wont get thrashed. So there is no need to 
> repatedly execute (for getting each map entry) the following two lines 
> inside jmpe820: of seutp.S and thus can be moved out as below.  Is there 
> any reason to do it inside?

Yes - BIOSes and the specification are only distant relatives. We get
all sorts of fun from them - 0 sized regions, system ROM reported as
RAM, E801 returns in the wrong registers and so on

