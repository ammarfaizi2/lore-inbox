Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbVCKMbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbVCKMbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbVCKMbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:31:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:12253 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263301AbVCKMat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:30:49 -0500
Subject: Re: [Linux-fbdev-devel] Re: [ACPI] inappropriate use of in_atomic()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Jan Kasprzak <kas@fi.muni.cz>, Paul Mackerras <paulus@samba.org>,
       jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net,
       acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       roland@topspin.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050311014601.166ae43d.akpm@osdl.org>
References: <20050310204006.48286d17.akpm@osdl.org>
	 <20050311091142.GB22415@fi.muni.cz> <20050311014601.166ae43d.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 23:26:13 +1100
Message-Id: <1110543974.5809.98.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 01:46 -0800, Andrew Morton wrote:
> Jan Kasprzak <kas@fi.muni.cz> wrote:
> >
> > This may be the cause of 
> > 
> >  http://bugme.osdl.org/show_bug.cgi?id=4150
> 
> Looks that way, yes.

Note that it would be interesting to fix that (I mean the reliability of
is_atomic() or an alternative). I agree it's quite bad to rely on that
in practice, but there are a few corner cases where it's useful (like
oops handling in fbdev's etc...)

Ben.


