Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUJCS4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUJCS4X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJCS4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:56:22 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:47094 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268083AbUJCS4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:56:09 -0400
Message-ID: <9e47339104100311566f66eb43@mail.gmail.com>
Date: Sun, 3 Oct 2004 14:56:07 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Merging DRM and fbdev
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sf.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041003183839.36810.qmail@web11903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910410030833e8a6683@mail.gmail.com>
	 <20041003183839.36810.qmail@web11903.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004 11:38:39 -0700 (PDT), Mike Mestnik
<cheako911@yahoo.com> wrote:
> What about moving the DRM and FB specific code into there own per card
> libs?
> 
> radeon - attached to hardware
>    radeon-drm
>       drm - library
>    radeon-fb
>       fb - library
>          fbcon - library

Fell free to convert the merged radeon driver in to a driver plus two
libs if you want. I'll accept the patch back. You'll need to wait
until I get the merged driver working.

What I don't want is two independent implementations of the hardware
initialization code like we currently have. The point of merging is to
make sure that a single logical driver programs the hardware is a
consistent way.

We spend so much time talking about splitting the radeon driver into
pieces. But I don't hear anyone saying I can't ship my product because
the radeon driver is 120K and all I can handle is 60K. I'm not going
to spend a week's work breaking things up and testing them just
because of some theoretical need for a non-existant embedded system.
When this hypothetical embedded system shows up the people making the
money off from the system can do the work.

If an embedded system is really that memory constrained they should
just use the existing fbdev radeon driver. There is no way a system
with that little of memory needs to worry about VT switching to X with
DRM.

-- 
Jon Smirl
jonsmirl@gmail.com
