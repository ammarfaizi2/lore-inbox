Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUC2BaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 20:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUC2BaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 20:30:16 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:52376 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262547AbUC2BaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 20:30:12 -0500
Message-ID: <40677C21.7070807@yahoo.com.au>
Date: Mon, 29 Mar 2004 11:30:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org> <40667734.8090203@yahoo.com.au> <20040328203357.GB6405@bounceswoosh.org> <20040328205917.GF6405@bounceswoosh.org>
In-Reply-To: <20040328205917.GF6405@bounceswoosh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:

>
> Er, forgot about the queue depth of only 2...
>
> Even in that case, you'll more than likely still get better throughput
> with a single 32-MB command...  If you send a pair of queued commands
> down, and the 2nd one is chosen, there's no reason that the first one
> won't get starved until the very end of the request, which would have
> bad latency on that command.
>

Well strictly, you send them one after the other. So unless you
have something similar to our anticipatory scheduler or plugging
mechanism, the drive should attack the first one first, shouldn't
it?


