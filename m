Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUF2WKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUF2WKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUF2WKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:10:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63447 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266110AbUF2WK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:10:26 -0400
Date: Tue, 29 Jun 2004 23:10:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: per-process namespace?
Message-ID: <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com> <40E1DABD.9000202@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E1DABD.9000202@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 05:10:21PM -0400, Mike Waychison wrote:
> Another caveat is that the current system disallows you from doing any
> mount/umount's in another namespace (bogus security?).

Nothing bogus here - namespace boundary _IS_ a trust boundary and that's
exactly the diference between symlinks and bindings - symlink attacks
are possible exactly because they allow you to modify visible tree topology
for other users.

Note that sharing parts of namespace (which is basically what automounter
wants and what we do not have yet) is deliberate act of trust - same as
having a part of your address space shared with other process.
