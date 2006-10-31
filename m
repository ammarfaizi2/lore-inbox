Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423622AbWJaRmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423622AbWJaRmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423715AbWJaRmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:42:54 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:8809 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423622AbWJaRmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:42:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=2jGYLc2fK0d3ZCstSnBVrySEPnD6O4p659UcwAVUvxQA2hNys1FuoTDqq79/9zlNcoqSbnn9J7B4TYrlVgruWyuM1VFPfIry2FwW5nQL0JmAIPbWBRBUqR6wBAeB2O5FoglCtBA7PWaSEy1X1xLBOUUR2RHMIW+Jw8dtqz4DAw8=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Date: Tue, 31 Oct 2006 10:40:15 -0700
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, Randy Dunlap <randy.dunlap@oracle.com>,
       akpm@osdl.org, zippel@linux-m68k.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, link@miggy.org,
       Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       greg@kroah.com, toralf.foerster@gmx.de
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610281410.13679.david-b@pacbell.net> <20061028213918.GE27968@stusta.de>
In-Reply-To: <20061028213918.GE27968@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200610310940.16619.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +#if defined(CONFIG_MII) || defined(CONFIG_MII_MODULE)
> > +#define HAVE_MII
> >...
> 
> This seems to cause a CONFIG_USB_USBNET=y, CONFIG_MII=m breakage
> (as already described earlier in this thread)?

Well, "alluded to" not described.  Fixable by the equivalent of

	config USB_USBNET
		...
		depends on MII if MII != n

except that Kconfig doesn't comprehend conditionals like that.


