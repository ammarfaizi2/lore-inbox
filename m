Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUJDRml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUJDRml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUJDRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:42:41 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:46518 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268344AbUJDRmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:42:36 -0400
Date: Mon, 4 Oct 2004 13:42:35 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <41617AA0.9020809@pobox.com>
Message-ID: <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <41617AA0.9020809@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got another oops while trying to cp from my md/raid5 array (2 of 3 
sata drives) to another sata drive on the same controller. This time, 
though, it said there's a bug in timer.c, line 405, and that the 
stack's garbage. I'm thinking it has nothing to do with timer.c, and 
something in md or libata is chomping all over the kernel.

It's odd that no one else is experiencing problems. I read a post where 
someone was sucessfully using a mandrake 2.6.8.1 kernel, with the same 
controller (promise tx4) and raid5. I suppose my controller card could be 
faulty, but it's odd that drives on the controller w/o raid seem to be 
doing alright.

I'm going to try a 2.4 kernel so I might be able to back up my array 
before things get really hairy. I should probably also ping Neil Brown or 
whoever the current md maintainer is. I'll continue to post findings.

Will
