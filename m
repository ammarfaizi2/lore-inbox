Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278222AbRJWUgg>; Tue, 23 Oct 2001 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278221AbRJWUg0>; Tue, 23 Oct 2001 16:36:26 -0400
Received: from zero.aec.at ([195.3.98.22]:2566 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278242AbRJWUgS>;
	Tue, 23 Oct 2001 16:36:18 -0400
To: Dave McCracken <dmccr@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Issue with max_threads (and other resources) and highmem
In-Reply-To: <72940000.1003868385@baldur>
From: Andi Kleen <ak@muc.de>
Date: 23 Oct 2001 22:36:51 +0200
In-Reply-To: Dave McCracken's message of "Tue, 23 Oct 2001 15:19:45 -0500"
Message-ID: <k28ze2drfg.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <72940000.1003868385@baldur>,
Dave McCracken <dmccr@us.ibm.com> writes:

> What's the best approach here?

I would just limit it to a reasonable max value; e.g. 10000
if someone needs more than 10000 threads/processes he/she can set sysctls
manually. The current scheduler would choke anyways if only a small
fraction of 10000 threads are runnable.

-Andi
