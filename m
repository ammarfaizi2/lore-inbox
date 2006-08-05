Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161443AbWHENXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161443AbWHENXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 09:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161440AbWHENXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 09:23:08 -0400
Received: from mga07.intel.com ([143.182.124.22]:12713 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161312AbWHENXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 09:23:07 -0400
X-IronPort-AV: i="4.07,214,1151910000"; 
   d="scan'208"; a="98608715:sNHT12904167843"
Message-ID: <44D49BAA.6050501@linux.intel.com>
Date: Sat, 05 Aug 2006 06:22:50 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Valerie Henson <val_henson@linux.intel.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de>
In-Reply-To: <20060805122537.GA23239@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Another idea, similar to how atime updates work in xfs currently might
> be interesting:  Always update atime in core, but don't start a
> transaction just for it - instead only flush it when you'd do it anyway,
> that is another transaction or evicting the inode.


this is sort of having a "dirty" and "dirty atime" split for the inode I suppose..
shouldn't be impossible to do with a bit of vfs support..
