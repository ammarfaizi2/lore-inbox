Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJADej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 23:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJADej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 23:34:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261891AbTJADei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 23:34:38 -0400
Date: Wed, 1 Oct 2003 04:34:37 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Message-ID: <20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <E1A4WNJ-000182-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A4WNJ-000182-00@calista.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 04:05:57AM +0200, Bernd Eckenfels wrote:
 
> > +#define MS_NODIRATIME  2048    /* Do not update directory access times */
> > +#define MS_BIND                4096
> > +#define MS_POSIXACL    (1<<16) /* VFS does not apply the umask */
> 
> can we clean that up? with shifting, without shifting, with comments and without comments? I suggest to use the linuxdoc comments mandatory for the abi files.


... and make it enum, while we are at it.  It's cleaner, it survives cpp
and it can be handled by gdb et.al. in sane way.

Unless we really want to support pre-v7 compilers, there is no benefit
in using #define for such constants.
