Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUCWE10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUCWE10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:27:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:1772 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261690AbUCWE1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:27:25 -0500
Subject: Re: Issues with /proc/bus/pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040322194759.7a38ffe9.davem@redhat.com>
References: <1080007613.22212.61.camel@gaston>
	 <20040322183126.16fe76cc.davem@redhat.com>
	 <1080009609.23717.81.camel@gaston>
	 <20040322194759.7a38ffe9.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1080015161.23717.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 15:12:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 14:47, David S. Miller wrote:
> On Tue, 23 Mar 2004 13:40:11 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > What do you think ?
> 
> Ok, it does sound like we need something else.

Ok, finally, I found out the truth about the ppc "fix" for that:
paulus did indeed fix it ... in 2.4 and not 2.5 :( Paul's fix is
simply to have the arch allow mapping of any address that is on
the host resource ranges, whatever the device was passed in (that
is basically the same as considering any device to be the host
bridge).

That should be completely compatible with userland looking for the
host bridge and would let me get the low VGA stuff for my video
softboot hack from the same device fd without having to look for
the host bridge at all.

Ben.


