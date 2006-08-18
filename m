Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWHRCVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWHRCVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 22:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWHRCVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 22:21:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932295AbWHRCVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 22:21:38 -0400
Date: Thu, 17 Aug 2006 22:20:57 -0400
From: Bill Nottingham <notting@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: xavier.bestel@free.fr, 7eggert@gmx.de, cate@debian.org,
       7eggert@elstempel.de, shemminger@osdl.org, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
Message-ID: <20060818022057.GA27076@nostromo.devel.redhat.com>
Mail-Followup-To: David Miller <davem@davemloft.net>, xavier.bestel@free.fr,
	7eggert@gmx.de, cate@debian.org, 7eggert@elstempel.de,
	shemminger@osdl.org, mitch.a.williams@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060816133811.GA26471@nostromo.devel.redhat.com> <Pine.LNX.4.58.0608161636250.2044@be1.lrz> <1155799783.7566.5.camel@capoeira> <20060817.162340.74748342.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817.162340.74748342.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller (davem@davemloft.net) said: 
> From: Xavier Bestel <xavier.bestel@free.fr>
> Date: Thu, 17 Aug 2006 09:29:43 +0200
> 
> > Why not simply retricting chars to isalnum() ones ?
> 
> As Bill said that would block things like "-" and "_" which are fine.
> 
> Bill also mentioned something about "breaking configs going back to
> 2.4.x" which is bogus because nothing broke when we started blocking
> "/" and "." and ".." in networking device names during the addition of
> sysfs support for net devices.

I was mainly referring to if we started to filter it out to isalnum() -
spaces/tab/CR etc. certainly could be filtered. (No idea what would
happen with unicode nbsp or other silly things.)

Bill
