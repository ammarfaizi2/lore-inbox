Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUHaGUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUHaGUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUHaGUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:20:11 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:11995
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266733AbUHaGUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:20:05 -0400
Message-ID: <41341894.3080606@bio.ifi.lmu.de>
Date: Tue, 31 Aug 2004 08:20:04 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christoph Hellwig <hch@mx20.domainteam.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read EXTRAVERSION from file
References: <20040830151405.GA18836@lst.de> <20040830161854.GA24580@mars.ravnborg.org>
In-Reply-To: <20040830161854.GA24580@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> This would fail for 2.6.8.1 for instance. Or at least the '1' that Linus 
> added would be part of the final EXTRAVERSION.
> 
> Ian Wienand <ianw@gelato.unsw.edu.au> posted a patch some time ago that
> introduces LOCALVERSION - it's in my queue but not applied since it
> needs some rework. And documentation also.
> That should be easy to extend to read the file localversion.

Nice idea, because we indeed ran into the problem with 2.6.8.1 that our
own extraversion we always set in the kernel rpms overwrite the .1. So
we are now extracting the EXTRAVERSION from the Makefile to add our
own stuff. All very ugly since the extraversion is contained e.g. in the
path of the kernel source file, and thus, setting an own extraversion
makes all the path stuff difficult.
A LOCALVERSION that was always uninitialized in the kernel.org packages
would be a nice thing, so that EXTRAVERSION could be left untouched.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

