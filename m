Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTIHOGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTIHOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:06:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31119 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262304AbTIHOGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:06:01 -0400
Date: Mon, 8 Sep 2003 15:05:43 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, jim.houston@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030908140543.GA26269@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain> <16197.14968.235907.128727@gargle.gargle.HOWL> <20030825060900.GA21213@mail.jlokier.co.uk> <20030903125019.GN1358@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903125019.GN1358@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > "SEP is unsupported".  It's interesting that Pentium Pro erratum #82
> > is "SYSENTER/SYSEXIT instructions can implicitly load 'null segment
> > selector' to SS and CS registers", implying that SYSENTER does
> > _something_ useful on PPros.
> 
> Well, with CS==0 machine is not going to survive too long.
> If it only happens sometimes you might catch the double fault
> and fixup, but....

The erratum only applies when you load CS==0 _deliberately_, by setting
the MSR to that.

I'm wondering what happens when you don't do silly things - what is
the undocumented behaviour of SYSENTER/SYSEXIT on those chips?

I vaguely recall reading details about the behaviour change made by
Intel, around the time it was done, but I can't see to find it
anywhere.

-- Jamie
