Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278087AbRJKEQN>; Thu, 11 Oct 2001 00:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278088AbRJKEQD>; Thu, 11 Oct 2001 00:16:03 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19573 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278087AbRJKEP5>; Thu, 11 Oct 2001 00:15:57 -0400
Date: Thu, 11 Oct 2001 00:16:20 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>,
        Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
Message-ID: <20011011001620.A18775@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com><m3elob3xao.fsf@belphigor.mcnaught.org><20011010173449.Q10443@turbolinux.com> <200110110133.f9B1XtN28012@vindaloo.ras.ucalgary.ca> <1160370000.1002764921@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1160370000.1002764921@tiny>; from mason@suse.com on Wed, Oct 10, 2001 at 09:48:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 09:48:41PM -0400, Chris Mason wrote:
> The bug where dump could corrupt things was when getblk and the
> block device both used the buffer cache.  That issue hasn't changed.

Let me emphasize this: 2.4.11+ will still exhibit filesystem corruption if 
the block device is accessed.  The only way to avoid this is to use raw io, 
in which case you know you're not getting a coherent view of things, so...

		-ben
