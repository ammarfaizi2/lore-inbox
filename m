Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRBBXQe>; Fri, 2 Feb 2001 18:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbRBBXQY>; Fri, 2 Feb 2001 18:16:24 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:42922 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129792AbRBBXQM>; Fri, 2 Feb 2001 18:16:12 -0500
Date: Fri, 2 Feb 2001 15:13:08 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "David S. Miller" <davem@redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <14971.15897.432460.25166@pizda.ninka.net>
Message-ID: <Pine.LNX.4.31.0102021511330.1221-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

right, assuming that there is enough sendfile() benifit to overcome the
write() penalty from the stuff that can't be cached or sent from a file.

my question was basicly are there enough places where sendfile would
actually be used to make it a net gain.

David Lang

On Fri, 2 Feb 2001, David S. Miller wrote:

> Date: Fri, 2 Feb 2001 15:09:13 -0800 (PST)
> From: David S. Miller <davem@redhat.com>
> To: David Lang <dlang@diginsite.com>
> Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
>      "netdev@oss.sgi.com" <netdev@oss.sgi.com>
> Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
>
>
> David Lang writes:
>  > Thanks, that info on sendfile makes sense for the fileserver situation.
>  > for webservers we will have to see (many/most CGI's look at stuff from the
>  > client so I still have doubts as to how much use cacheing will be)
>
> Also note that the decreased CPU utilization resulting from
> zerocopy sendfile leaves more CPU available for CGI execution.
>
> This was a point I forgot to make.
>
> Later,
> David S. Miller
> davem@redhat.com
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
