Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVGNN2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVGNN2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVGNN2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:28:30 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:40937 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261381AbVGNN20 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:28:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJFPQuUwWL1CKFg8WH8uPjuvwzD6smT5Ss1+8vbuHp620xMm5RLg7ao7Mti99+efdhsejBzCdMwKgABp3FNe33h2MrazjIctiWEQbPhpcylCI/0W6FZ0ReovLCb1Ii0OZMP4DZGZ7kriJN3o7PRtcdwc87pieFLjyqzDNozjlhg=
Message-ID: <9e47339105071406274e207fc3@mail.gmail.com>
Date: Thu, 14 Jul 2005 09:27:42 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050714155344.A27478@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714155344.A27478@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> The setup-bus code doesn't work correctly for configurations
> with more than one display adapter in the same PCI domain.
> This stuff actually is a leftover of an early 2.4 PCI setup code
> and apparently it stopped working after some "bridge_ctl" changes.
> So the best thing we can do is just to remove it and rely on the fact
> that any firmware *has* to configure VGA port forwarding for the boot
> display device properly.

This fixes my system where the VGA display device is on the second bus.

-- 
Jon Smirl
jonsmirl@gmail.com
