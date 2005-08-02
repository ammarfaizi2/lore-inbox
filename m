Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVHBJ4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVHBJ4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVHBJyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:54:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10470 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261447AbVHBJxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:53:20 -0400
Date: Tue, 2 Aug 2005 11:53:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, ebiederm@xmission.com
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-ID: <20050802095312.GA1442@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122908972.18835.153.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why are we calling driver suspend routines in these ? This is _not_

Well, reason is that if you remove device_suspend() you'll get
emergency hard disk park during powerdown. As harddrives can survive
only limited number of emergency stops, that is not a good idea.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
