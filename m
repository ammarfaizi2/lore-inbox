Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319061AbSIJAV5>; Mon, 9 Sep 2002 20:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319062AbSIJAV5>; Mon, 9 Sep 2002 20:21:57 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:12483 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319061AbSIJAV4>;
	Mon, 9 Sep 2002 20:21:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] On paging of kernel VM.
Date: Tue, 10 Sep 2002 02:28:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-mm@kvack.org
References: <2653.1031563253@redhat.com>
In-Reply-To: <2653.1031563253@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oYth-0006wD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 11:20, David Woodhouse wrote:
> But as I said, this means screwing with every fault handler. It doesn't 
> have to affect the fast path -- we can go looking for these vmas only in 
> the case where we've already tried looking for the appropriate pte in 
> init_mm and haven't found it. But it's still an intrusive change that would 
> need to be done on every architecture.

Why can't you go per-architecture and fall back to the slow way of doing it
for architectures that don't have the new functionality yet?

-- 
Daniel
