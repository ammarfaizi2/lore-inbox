Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWAHT15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWAHT15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWAHT15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:27:57 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:24993 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161077AbWAHT14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:27:56 -0500
From: Grant Coady <gcoady@gmail.com>
To: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>,
       Markus Rechberger <mrechberger@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Mon, 09 Jan 2006 06:27:52 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <shp2s11s37hesljm15qej3s0fq9qal2d32@4ax.com>
References: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com> <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <gre1s1lkr687o2npgom26gqq3etgjdjgpo@4ax.com> <20060108095741.GH7142@w.ods.org> <eto1s19q78qg34o5uq37o46t30f3adfn0q@4ax.com> <20060108102101.770a395f@octavio.alvarezp.pri>
In-Reply-To: <20060108102101.770a395f@octavio.alvarezp.pri>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 10:21:01 -0800, Octavio Alvarez Piza <alvarezp@alvarezp.ods.org> wrote:

>On Sun, 08 Jan 2006 22:05:43 +1100
>Grant Coady <gcoady@gmail.com> wrote:
>
>> On Sun, 8 Jan 2006 10:57:41 +0100, Willy Tarreau <willy@w.ods.org> wrote:
>> 
>> > Could you please retest :
>> >  - without the pipe (remove '| cut ...') to avoid inter-process
>> >    communications
>> 
>> I thought it made a difference, then delay back again, I'll try 
>> again tomorrow when I'm more awake.
>> 
>> >You should be able to find one simple pattern which makes the problem
>> >appear/disappear on 2.6. At least, 'cat x.log >/dev/null' should not
>> >take time or that time should be spent in I/O.
>> 
>> Yes, done that and the time went down by ~five seconds.
>
>Just make sure you first read all the file with cat (I'd retry all from
>the initial tests) so you don't add hd-read time to the first command.

I do notice occasional pauses (just a slight jerkiness) in output 
from log file, perhaps when it is appended to.  As I wrote earlier, 
this one liner is something I do fairly often to see what is hitting 
the web server, the 'cut -c -96' is because I run 96 character 
wide ssh terminals.

Grant.
