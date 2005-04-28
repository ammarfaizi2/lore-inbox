Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVD1RgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVD1RgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVD1Rf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:35:59 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:33102 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262187AbVD1Rff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:35:35 -0400
Date: Thu, 28 Apr 2005 10:35:01 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: David Teigland <teigland@redhat.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050428173501.GG938@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050426053930.GA12096@redhat.com> <20050426184845.GA938@ca-server1.us.oracle.com> <20050427132343.GX4431@marowsky-bree.de> <20050427181245.GB938@ca-server1.us.oracle.com> <20050428143619.GZ21645@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428143619.GZ21645@marowsky-bree.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:36:19PM +0200, Lars Marowsky-Bree wrote:
> On 2005-04-27T11:12:45, Mark Fasheh <mark.fasheh@oracle.com> wrote:
> 
> > The short answer is no but that we're collecting them. Right now, I can say
> > that if you take our whole stack into consideration OCFS2 for things like
> > kernel untars and builds (a common test over here), is typically almost as
> > fast as ext3 (single node obviously) even when we have a second or third
> > node mounted.
> 
> Well, agreed that's great, but that seems to imply just generic sane
> design: Why should the presence of another node (which does nothing, or
> not with overlapping objects on disk) cause any substantial slowdown?
See my discussion with David regarding LKM_LOCAL to see how the dlm still
comes into play, even when you have few disk structures to ping on. A
cluster file system is more than just sane disk design :)

Other things come into play there too, like how resources masters are
determined, whether they can be migrated etc. These can have an effect even
when you're doing work mostly within your own area of disk.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

