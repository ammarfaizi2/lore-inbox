Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310192AbSCKQbb>; Mon, 11 Mar 2002 11:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310193AbSCKQbV>; Mon, 11 Mar 2002 11:31:21 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60432 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S310192AbSCKQbN>; Mon, 11 Mar 2002 11:31:13 -0500
Message-ID: <3C8CDBCA.8010402@namesys.com>
Date: Mon, 11 Mar 2002 19:31:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: trond.myklebust@fys.uio.no, green@namesys.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>	<200203110018.BAA11921@webserver.ithnet.com>	<15499.64058.442959.241470@charged.uio.no>	<20020311091458.A24600@namesys.com>	<20020311114654.2901890f.skraw@ithnet.com>	<20020311135256.A856@namesys.com>	<20020311155937.A1474@namesys.com>	<20020311154852.3981c188.skraw@ithnet.com>	<20020311165140.A1839@namesys.com>	<15500.47144.705329.809604@charged.uio.no> <20020311165722.692209c3.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

>On Mon, 11 Mar 2002 14:59:04 +0100
>Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
>>>>>>>" " == Oleg Drokin <green@namesys.com> writes:
>>>>>>>
>>     > Trod, do you think that'll work or should some other non-ext2
>>     > fs be tried?
>>
>>Ext2 should work fine: I've never seen any problems such as that which
>>Stephan describes, and certainly not with 2.4.18 clients.
>>
>>In any case, any occurence of an ESTALE error *must* first have
>>originated from the server. The client itself cannot determine that a
>>filehandle is stale.
>>
>
>Next try:
>I have now in addition to the /backup and /mnt reiserfs exports created another
>ext2 export. First test case:
>mount /backup, mount the ext2 fs on /test, then mount /mnt, do i/o on /mnt and
>umount /mnt.
>After that everything works! /test works _and_ /backup works!
>
>Second test case: (server and client have several network cards, so I can mount
>on other ips as well)
>mount /backup, mount /mnt on ip1, mount /test on ip2 (from same server). do i/o
>on /mnt and umount /mnt.
>After that /test works, but/backup is stale.
>
>Conclusion: reiserfs has a problem being nfs-mounted as the only fs to a
>client. If you add another fs (here ext2) mount, then even reiserfs is happy.
>The problem is originated at the server side.
>
>Any ideas for a fix?
>
>Regards,
>Stephan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Oleg will be back at work in 16 hours;-)

Hans


