Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTIHT5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTIHT5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:57:00 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:9889 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263590AbTIHT4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:56:55 -0400
Date: Mon, 8 Sep 2003 20:55:43 +0100
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Stian Jordet <liste@jordet.nu>, Mika Liljeberg <mika.liljeberg@welho.com>,
       linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
Subject: Re: New ATI FireGL driver supports 2.6 kernel
Message-ID: <20030908195543.GE646@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@fenrus.demon.nl>,
	Stian Jordet <liste@jordet.nu>,
	Mika Liljeberg <mika.liljeberg@welho.com>,
	linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
References: <1063044345.1895.10.camel@hades> <1063045080.21991.13.camel@chevrolet.hybel> <20030908184117.GA681@redhat.com> <1063047781.22153.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063047781.22153.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 09:03:02PM +0200, Arjan van de Ven wrote:
 > 
 > > Comedy. So the story so far..
 > > 
 > > - ATI grab 2.4.16's AGP driver.
 > > - Working AGP3 support happens in 2.5
 > > - ATI gets backported to 2.4 and 'munged'.
 > > - Additional fixes go into 2.5
 > > - ATI forwardport their trainwreck to 2.6.
 > > 
 > > It shouldn't have *any* need whatsoever to touch agpgart in 2.6.
 > 
 > isn't the 2.5 AGP GPL licensed? How can ATI then include it in a bin
 > only module ? ....

They do some pretty evil stuff like..

+#ifdef STANDALONE_MODULE
 MODULE_LICENSE("GPL")
+#endif

Some of the folks at ATI really seem to be quite clued and 'get it'
(Like those responsible for sorting out the Radeon IGP GART driver).
On the other side of the coin the FireGL driver folks just get worse
every time. If they actually *tried* to communicate with the community
what they need from agpgart that its so obviously lacking, then there'd
be no need for any of this nonsense.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
