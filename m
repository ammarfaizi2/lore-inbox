Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVDETcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVDETcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVDET3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:29:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30122 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261738AbVDET20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:28:26 -0400
Message-ID: <4252E6C1.5010701@pobox.com>
Date: Tue, 05 Apr 2005 15:28:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josselin Mouette <joss@debian.org>
CC: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 	copyright notice.
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet>
In-Reply-To: <1112723637.4878.14.camel@mirchusko.localnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josselin Mouette wrote:
> Finally, you shouldn't forget that, technically speaking, using hotplug
> for uploading the firmware is much more flexible and elegant than
> including it in the kernel. Upgrading the firmware and the module should
> be two independent operations. People who are advocating the current
> situation are refusing technical improvements just because they are
> brought by people they find convenient to call "zealots".

This is highly amusing, coming from someone who does not maintain a 
driver with a firmware.

The current firmware infrastructure is too primitive.  Compiling the 
firmware into the driver is much easier on the driver maintainers and 
users, presently.

Repeating myself,

* Most firmwares are a -collection- of images and data.  The firmware 
infrastructure should load an -archive- of firmwares and associated data 
values.

* The firmware distribution infrastructure is basically non-existent. 
There is no standard way to make sure that a firmware separated from the 
driver gets to all users.

* The firmware bundling infrastructure is basically non-existent. 
(Arjan talked about this)  There needs to be a a way to ensure that the 
needed firmwares are automatically added to initramfs/initrd.

* There is no chicken-and-egg problem as Arjan mentions.  Once the above 
technical problems are resolved, its trivial to apply a firmware loading 
patch.  I believe in hard transitions, not shipping tg3 with firmware 
-and- a firmware loading patch.

* Firmwares such as tg3 should be shipped with the kernel tarball.

In short, there are plenty of technical problems to resolve before this 
is even a reasonable request.  Currently, a user upgrading to a tg3 sans 
firmware will simply get tg3 sans firmware.

	Jeff


