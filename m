Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbUDSMV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264390AbUDSMV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:21:28 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:6488 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264385AbUDSMV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:21:26 -0400
Message-ID: <4083C413.90509@yahoo.com.au>
Date: Mon, 19 Apr 2004 22:20:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Antti Lankila <alankila@elma.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: elevator=as related to my performance issues
References: <Pine.A41.4.58.0404191355100.42820@tokka.elma.fi>
In-Reply-To: <Pine.A41.4.58.0404191355100.42820@tokka.elma.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Lankila wrote:
> I'm sorry that I can't post this mail in reply to the thread, this is
> because I'm not subscribed, so I can't reply.
> 

[snip]

So it doesn't seem like you are losing interrupts. And
it doesn't appear to be confined to the anticpatory
scheduler - definitely nothing fundamental because setting
antic_expire = 0 still gives you problems.

The only other problems I can think of that you might be
having are chipset problems, or CPU scheduler problems.
Which reminds me, do you have your X server at nice 0?
If not, try:
renice 0 `pidof X`

and let us know how you go.
