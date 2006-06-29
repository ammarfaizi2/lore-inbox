Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWF2VLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWF2VLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWF2VLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:11:36 -0400
Received: from relay03.pair.com ([209.68.5.17]:26380 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932656AbWF2VLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:11:35 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 29 Jun 2006 16:11:26 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Hans Reiser <reiser@namesys.com>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] batch-write.patch
In-Reply-To: <44A42750.5020807@namesys.com>
Message-ID: <Pine.LNX.4.64.0606291609020.5747@turbotaz.ourhouse>
References: <44A42750.5020807@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Hans Reiser wrote:

>
> (patch was attached)
>

Not quoted because patch isn't inlined, but you're testing for the 
presence of the batch_write pointer repeatedly in the loop. How about 
declare a batch_write ptr on the stack and then do your test once, outside 
of your do { } while (count) loop, and then set it to the generic method 
(before entering the loop) if the generic method isn't available?

Thanks,
Chase
