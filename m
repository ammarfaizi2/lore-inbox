Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSHUAYa>; Tue, 20 Aug 2002 20:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSHUAY3>; Tue, 20 Aug 2002 20:24:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50684 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317590AbSHUAY0>; Tue, 20 Aug 2002 20:24:26 -0400
Subject: RE: mdelay causes BUG, please use udelay
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, tcw@prismnet.com
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 01:28:52 +0100
Message-Id: <1029889732.22983.87.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 01:20, Feldman, Scott wrote:
> > +    usec_delay(10000);
> 
> Jeff, 10000 seems on the border of what's OK.  If it's acceptable, then
> let's go for that.  Otherwise, we're going to have to chain several
> mod_timer callbacks together to do a controller reset.

For some telco and embedded apps 10000 in an IRQ is borderline. One day
the timer stuff will be needed - how hard is it to fix right first time
?

