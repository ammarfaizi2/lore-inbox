Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWA3WRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWA3WRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWA3WRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:17:52 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46827 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932388AbWA3WRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:17:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [ 15/23] [Suspend2] Helper for counting uninterruptible threads of a type.
Date: Mon, 30 Jan 2006 23:18:28 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126034556.3178.79337.stgit@localhost.localdomain>
In-Reply-To: <20060126034556.3178.79337.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601302318.28922.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> 
> Add a helper which counts the number of patches of a type (all
> or userspace only) which are in TASK_UNINTERRUPTIBLE state.
> These tasks are signalled (just in case they leave that state at
> a later point), but we do not consider freezing to have failed
> if and when they do not enter the freezer.
> 
> Note that when they eventually leave TASK_UNINTERRUPTIBLE state,
> they will enter the refrigerator, but will immediately exit if
> we no longer want to freeze at that point.

I think we need to do something like this to prevent problems with
freezing under load.

Greetings,
Rafael
