Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133120AbRDWOOu>; Mon, 23 Apr 2001 10:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135220AbRDWOOk>; Mon, 23 Apr 2001 10:14:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12703 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133120AbRDWOOX>;
	Mon, 23 Apr 2001 10:14:23 -0400
Date: Mon, 23 Apr 2001 10:14:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David L. Parsley" <parsley@linuxjedi.org>
cc: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org,
        ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <3AE4374D.F3A60F95@linuxjedi.org>
Message-ID: <Pine.GSO.4.21.0104231010320.3617-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, David L. Parsley wrote:

> What I'm not sure of is which solution is actually 'better' - I'm
> guessing that performance-wise, neither will make a noticable
> difference, so I guess memory usage would be the deciding factor.  If I

Bindings are faster on lookup. For obvious reasons - in case of symlinks
you do name resolution every time you traverse the link; in case of
bindings it is done when you create them.

