Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWHAS0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWHAS0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWHAS0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:26:42 -0400
Received: from relay03.pair.com ([209.68.5.17]:49166 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751773AbWHAS0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:26:41 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 1 Aug 2006 13:26:38 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: linux-kernel@vger.kernel.org
Subject: lib/errno.c
Message-ID: <Pine.LNX.4.64.0608011316340.12077@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious if there's a reason we're still carrying "lib/errno.c". 
The string "errno" is used pretty heavily but from a grep glance it seems 
any users define it locally (and indeed, the concurrency issues with a global 
'errno' symbol mean it would be worthless except during boot, or maybe 
under BKL).

Thanks,
Chase
