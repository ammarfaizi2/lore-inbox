Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbRGPA5n>; Sun, 15 Jul 2001 20:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbRGPA5X>; Sun, 15 Jul 2001 20:57:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48627 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267173AbRGPA5M>;
	Sun, 15 Jul 2001 20:57:12 -0400
Date: Sun, 15 Jul 2001 20:57:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: volodya@mindspring.com
cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <Pine.LNX.4.20.0107152032440.1154-100000@node2.localnet.net>
Message-ID: <Pine.GSO.4.21.0107152051340.24930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jul 2001 volodya@mindspring.com wrote:

> Umm that is very interesting - I was rather sure there were some problems
> a while ago (2.2.x ?). Is there anything special necessary to use large
> files ? Because I tried to create a 3+gig file and now I cannot ls or rm
> it. (More details: the file was created using dd from block device (tried
> to backup a smaller ext2 partition), ls and rm say  "Value too large for
> defined data type" and I upgraded everything mentioned in Documentation/Changes).

<shrug> you need fileutils built with large file support enabled (basically,
it should use stat64(), etc. and pass O_LARGEFILE to open()) and you need
sufficiently recent libc. But that's the same regardless of fs type.

