Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTKXCjI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 21:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTKXCjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 21:39:08 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60809 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263580AbTKXCjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 21:39:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 23 Nov 2003 18:39:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] generalise scheduling classes
In-Reply-To: <3FC16C60.7040604@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0311231833310.12172-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc list trimmed. There was the whole world]

On Mon, 24 Nov 2003, Nick Piggin wrote:

> Technically the scheduler knows nothing about NUMA. Previously it had
> local and a remote domains corresponding to inter and intra node cpu sets.
> All it did was to do remote balancing a little more gently. But we'll call
> it NUMA scheduling.

One patch I did ages ago was using a topology matrix NxN storing distances 
(read move weights) from each CPU: mat[i][j] == distance/weight i <-> j
At that time the matrix was bolt-in since there was no topology API. maybe 
now can be built a little bit more wisely using HT and NUMA topology info.



- Davide


