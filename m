Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWEBF4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWEBF4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWEBF4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:56:32 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:11232 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932382AbWEBF4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:56:31 -0400
Date: Tue, 2 May 2006 07:56:21 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking metadata clean, and make it configurable.
Message-ID: <20060502055621.GA552@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060501152229.18367.patches@notabene> <1060501053019.22949@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060501053019.22949@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 03:30:19PM +1000, NeilBrown wrote:
> When a md array has been idle (no writes) for 20msecs it is marked as
> 'clean'.  This delay turns out to be too short for some real
> workloads.  So increase it to 200msec (the time to update the metadata
> should be a tiny fraction of that) and make it sysfs-configurable.

What does this mean, 'too short'? What happens in that case, backing block
devices are still busy writing? When making this configurable, the help text
better explain what the trade offs are.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
