Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVAGHjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVAGHjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVAGHjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:39:24 -0500
Received: from canuck.infradead.org ([205.233.218.70]:57353 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261303AbVAGHjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:39:11 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com
In-Reply-To: <Pine.LNX.4.58.0501061623350.2272@ppc970.osdl.org>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org>
	 <1105053007.17176.291.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501061623350.2272@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 08:38:54 +0100
Message-Id: <1105083535.4179.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 16:24 -0800, Linus Torvalds wrote:
> 
> On Thu, 6 Jan 2005, Alan Cox wrote:
> 
> > On Iau, 2005-01-06 at 23:26, Andrew Morton wrote:
> > > I think the exports should be restored.  So does Linus ("Not that I like it
> > > all that much, but I don't think we should break existing modules unless we
> > > have a very specific reason to break just those modules.").
> > 
> > What happens when the feature is just not (ab)usable in the way proposed ? 
> 
> At that point there is a specific _reason_ to break it, aka "that function 
> simply doesn't exist any more".

how about "it can be static, and static functions without external
references can be better optimized by gcc (and are, as of version 3.4)"
(where function pointers are seen as external references, and
EXPORT_SYMBOL does just that)


