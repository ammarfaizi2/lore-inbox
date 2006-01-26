Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWAZXQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWAZXQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWAZXQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:16:08 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43479 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030219AbWAZXQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:16:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Date: Fri, 27 Jan 2006 00:10:22 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601270010.22702.rjw@sisk.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 26 January 2006 04:45, Nigel Cunningham wrote:
> Hi everyone.
> 
> This set of patches represents the freezer upgrade patches from Suspend2.
> 
> The key features of this changeset are:
> 
> - Use of Christoph Lameter's todo list notifiers, which help with SMP
>   cleanness.
> - Splitting the freezing of kernel and userspace processes. Freezing
>   currently suffers from a race because userspace processes can be
>   submitting work for kernel threads, thereby stopping them from
>   responding to freeze messages in a timely manner. The freezer can
>   thus give up when it doesn't really need to. (This is not normally
>   a problem only because load is not usually high).

Could you please describe specific situation?

> - The use of bdev freezing to ensure filesystems are properly frozen,
>   thereby increasing the integrity of on-disk data in the case where
>   a resume doesn't occur. This is also helpful in the case of Suspend2,
>   where we don't atomically copy all memory, instead writing LRU pages
>   separately.

Is this also needed when we do atomically copy all memory?

Greetings,
Rafael

