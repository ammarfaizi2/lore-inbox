Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSJISAJ>; Wed, 9 Oct 2002 14:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSJIR7A>; Wed, 9 Oct 2002 13:59:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1220 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261866AbSJIR6u>;
	Wed, 9 Oct 2002 13:58:50 -0400
Date: Wed, 9 Oct 2002 14:04:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091058230.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210091400590.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Patrick Mochel wrote:

> What describes partitions, struct hd_struct? By adding a struct 
> driver_dir_entry (yes, crappy name; will change) and a bit of glue logic, 
> we can create driverfs directories for them, and start adding attributes 
> to the partitions themselves. 

_What_ attributes?  List of PIDs that hold it open?  List of <something>
for all SCM_RIGHTS cookies that happen to pass opened file for that
partition around?

Guys, you are overengineering for no good reason, AFAICS.  There is a
good reason why fuser(1) sits in userland and is not done as a property
list for open file.  It's exactly the same situation.

