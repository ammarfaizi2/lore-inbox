Return-Path: <linux-kernel-owner+w=401wt.eu-S1755371AbXABQoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbXABQoX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbXABQoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:44:23 -0500
Received: from outbound-mail-61.bluehost.com ([69.89.21.21]:43493 "HELO
	outbound-mail-61.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755371AbXABQoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:44:22 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 11:44:22 EST
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] quiet MMCONFIG related printks
Date: Tue, 2 Jan 2007 08:37:44 -0800
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
References: <200701012101.38427.jbarnes@virtuousgeek.org> <20070102103602.28a873ea@localhost.localdomain>
In-Reply-To: <20070102103602.28a873ea@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020837.45016.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 2, 2007 2:36 am, Alan wrote:
> On Mon, 1 Jan 2007 21:01:38 -0800
>
> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> > Using MMCONFIG for PCI config space access is simply an
> > optimization, not a requirement.  Therefore, when it can't be used,
> > there's no need for
>
> Some hardware reqires MCFG. In addition this is an error, a real
> error on the vendors part or ours and could indicate there are many
> other BIOS problems outstanding.

Ok, I was mistaken then.  However, I see this on several boxes, and the 
broken BIOSen out in the wild are unlikely to be fixed.  Maybe this 
should really be a KERN_WARNING instead since it may indicate that some 
devices will fail to work?

> We shouldn't keep quiet about serious errors in tables, we need
> people to know and be able to take appropriate action (eg new BIOSen,
> refusing certifications etc).

Ok.

Jesse
