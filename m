Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278206AbRJMADa>; Fri, 12 Oct 2001 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278209AbRJMADU>; Fri, 12 Oct 2001 20:03:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44243 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278206AbRJMADD>;
	Fri, 12 Oct 2001 20:03:03 -0400
Date: Fri, 12 Oct 2001 20:03:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Etay Meiri <cl1@netvision.net.il>
cc: linux-kernel@vger.kernel.org
Subject: Re: exporting open_namei to modules
In-Reply-To: <20011013011841.B1069@amber.rog.net>
Message-ID: <Pine.GSO.4.21.0110121955470.76-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Etay Meiri wrote:

> Hi,
> 
> Is there a particular reason why open_namei() is
> not exported to modules?

	Is there any reason for exporting it?  By default, stuff is _NOT_
exported.  Think for a moment and you'll see why.  Exported functions are
public API.  Protection is weaker than for syscalls, but it's there and
exporting a function makes harder to do changes in core kernel.  Unless
there are damn serious reasons for exporting something, it isn't done.

	In particular, open_namei() is a helper function of filp_open(),
which _is_ exported.  What use of open_namei() do you have in mind?

