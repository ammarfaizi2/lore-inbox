Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268429AbTBNNrr>; Fri, 14 Feb 2003 08:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268430AbTBNNrr>; Fri, 14 Feb 2003 08:47:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12418
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268429AbTBNNrp>; Fri, 14 Feb 2003 08:47:45 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Matt Porter <porter@cox.net>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200302141348.h1EDmHwZ004754@turing-police.cc.vt.edu>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	 <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
	 <20030213155817.B1738@home.com>
	 <200302141348.h1EDmHwZ004754@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045234657.7958.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 14:57:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 13:48, Valdis.Kletnieks@vt.edu wrote:
> I admit not having thoroughly read the source to check - is the userspace API
> for accessing  all these chips fairly uniform and rational, so that a user
> program can be reasonably sure that if stat("/dev/watchdog") returns zero, that
> it knows how to deal with it?  Or are they all sufficiently close to the "keep
> reloading a countdown timer from userspace, and if it ever doesn't get reloaded,
> kick the kernel in the seat of the pants" programming model?  Of course, even
> a disagreement on the units of the timer could be bad - a seconds/milliseconds
> clash could result is a *real* fast lack-of-joy situation.. ;)

watchdog interfaces have a defined API, which they all follow fairly closely. That
makes adding watchdogs as a device class nice and easy

