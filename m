Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273617AbRIQOF6>; Mon, 17 Sep 2001 10:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273618AbRIQOFs>; Mon, 17 Sep 2001 10:05:48 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:27916 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S273617AbRIQOFc>; Mon, 17 Sep 2001 10:05:32 -0400
Message-ID: <3BA602FA.247C808B@mediascape.de>
Date: Mon, 17 Sep 2001 16:04:42 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance> <9o1dev$23l$1@penguin.transmeta.com> <1000722338.14005.0.camel@x153.internalnet> <9o2v1r$85g$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [...]
> What do you want to happen? You want to have an interface like
> 
>         echo 0 > /proc/bugs/mm
> 
> that makes mm bugs go away?

Good idea! ;-)

Well, I had similar problems and went back to 2.2.19... but isn't there a
tuneable yet?

On http://www.badtux.org/eric/editorial/mindcraft.html I found this one:

'Tuning the file buffer size so that more than 60% of memory can be used
(90% in this example) can be accomplished by issuing the following command:
echo "2 10 90" >/proc/sys/vm/buffermem"
This is documented in the file /usr/src/linux/Documentation/sysctl/vm.txt
along with many other tuning parameters, such as the 'bdflush' parameter.'


But vm.txt from 2.4.9ac10 and 2.2.19 says:

buffermem:

The three values in this file correspond to the values in
the struct buffer_mem. It controls how much memory should
be used for buffer memory. The percentage is calculated
as a percentage of total system memory.

The values are:
min_percent     -- this is the minimum percentage of memory
                   that should be spent on buffer memory
borrow_percent  -- UNUSED
max_percent     -- UNUSED

Is vm.txt out of date, or is there really no tuneable, neither in 2.2.x nor
in 2.4.x?

Olaf
