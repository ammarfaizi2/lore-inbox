Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSJCOM5>; Thu, 3 Oct 2002 10:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263325AbSJCOM5>; Thu, 3 Oct 2002 10:12:57 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:11532 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263321AbSJCOMx>; Thu, 3 Oct 2002 10:12:53 -0400
Date: Thu, 3 Oct 2002 15:17:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.5.40-ac1
Message-ID: <20021003151707.A17513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@redhat.com>
References: <3D9B8363.6030806@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9B8363.6030806@snapgear.com>; from gerg@snapgear.com on Thu, Oct 03, 2002 at 09:38:11AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 09:38:11AM +1000, Greg Ungerer wrote:
> What do you think about the separate mm/mmnommu directories
> at the top level?  Should the mmnommu be merged into mm?

The sepearate one is horrible maintaince wise.  Please introduce
CONFIG_MMU and try to make as many _files_ in mm/ conditional on
those.  Else use the proper ways (cond_syscall(), inline stubs) to
hide the differences.


