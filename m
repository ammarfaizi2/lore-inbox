Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDXMz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDXMz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDXMz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:55:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57779 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750765AbWDXMzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:55:25 -0400
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tony Jones <tonyj@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060420053604.GA15332@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com>
	 <20060419221248.GB26694@infradead.org>  <20060420053604.GA15332@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 14:05:48 +0100
Message-Id: <1145883948.29648.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-04-19 at 22:36 -0700, Tony Jones wrote:
> "system root".  When a task chroots relative to it's current namespace, we
> are interested in the path back to the root of that namespace, rather than
> to the chroot.  I believe the patch as stands achieves this, albeit with
> some changing of comments.

If the directory the task is in has been deleted then what is its path
relative to the namespace ? This isn't theoretical because if your
security profiles work on the basis of this path but do not prevent the
deletion of the current directory or some node above it (or doing
mkdir/chdir/rmdir sequences) an app may be able to subvert it by doing
this deliberately.

