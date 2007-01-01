Return-Path: <linux-kernel-owner+w=401wt.eu-S1751728AbXAATGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbXAATGK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbXAATGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:06:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbXAATGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:06:09 -0500
Date: Mon, 1 Jan 2007 14:05:38 -0500
From: Dave Jones <davej@redhat.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Paul Mundt <lethal@linux-sh.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-ID: <20070101190538.GA20443@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Folkert van Heusden <folkert@vanheusden.com>,
	Paul Mundt <lethal@linux-sh.org>,
	Denis Vlasenko <vda.linux@googlemail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200612302149.35752.vda.linux@googlemail.com> <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain> <1167518748.20929.578.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain> <20061231183949.GA8323@linux-sh.org> <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain> <20070101015932.GP13521@vanheusden.com> <Pine.LNX.4.64.0701010332130.3084@localhost.localdomain> <1167646450.20929.921.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0701010515560.6039@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701010515560.6039@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 05:27:10AM -0500, Robert P. J. Day wrote:

 > > both look good... I'd be in favor of this. Maybe also add a part
 > > about using GFP_KERNEL whenever possible, GFP_NOFS from filesystem
 > > writeout code and GFP_NOIO from block writeout code (and never doing
 > > in_interrupt()?GFP_ATOMIC:GFP_KERNEL !)
 > 
 > it strikes me that that latter part is starting to go beyond the scope
 > of simple coding style aesthetics and getting into actual coding
 > distinctions.  would that really be appropriate for the CodingStyle
 > doc?  i'm just asking.

Adding a separate 'good practices' doc wouldn't be a bad idea.

		Dave

-- 
http://www.codemonkey.org.uk
