Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVJUSXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVJUSXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVJUSXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:23:47 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:53646 "EHLO
	churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S965068AbVJUSXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:23:46 -0400
Message-ID: <43593240.9020806@churchillrandoms.co.uk>
Date: Fri, 21 Oct 2005 11:24:00 -0700
From: Stefan Jones <stefan.jones@churchillrandoms.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051003)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.6.13.4] Memoryleak - idr_layer_cache slab - inotify?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I noticed this a while back when gam_server (new fam replacement)
started playing up and the idr_layer_cache slab used up 300Mb of RAM.

To reproduce:

Run gnome and make sure it is using gam_server for fam.

In one console do:

while true ;do sleep 0.1 ; killall -w gam_server; done

In another try slabtop and see the idr_layer_cache slab climb, eating
memory (abit slowly).
( Gnome restarts gam_server after each kill for you and gets it doing
stuff )

I looked though the source and inotify does use the idr_layer_cache slab
and gam_server also uses inotify.

Thank for your time, shall I use bugzilla.kernel or is this ok? More
info needed?

Stefan



