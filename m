Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267260AbTGTQEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 12:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbTGTQEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 12:04:55 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:59398
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S267260AbTGTQEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 12:04:54 -0400
Subject: Re: 2.6.0-test1: autofs4 doesn't expire
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Dick Streefland <dick.streefland@xs4all.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1d60.3f1a9267.2bf5e@altium.nl>
References: <65b6.3f1a6fae.1d70b@altium.nl>  <1d60.3f1a9267.2bf5e@altium.nl>
Content-Type: text/plain
Message-Id: <1058717993.5980.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 09:19:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 06:00, Dick Streefland wrote:
> spam@streefland.xs4all.nl (Dick Streefland) wrote:
> | In 2.6.0-test1, the autofs4 automounter doesn't expire mounts anymore,
> | both NFS and CDROM mounts. It did work in my previous kernel, 2.5.72.
> | When I try to unmount manually, I get "device is busy", although
> | "fuser -m" doesn't report anything. I've also searched /proc/*/fd/,
> | but there are no open files below the mount points.
> | 
> | Is anybody else seeing this? Any ideas what could be the cause?
> 
> Update: 2.5.75 is OK, so the problem was introduced in 2.6.0-test1.
> I have not yet verified it, but I suspect that the addition of the
> mntget() call is the cause:

Hm, that does look like it would upset autofs4.  I'll take a look.

	J

