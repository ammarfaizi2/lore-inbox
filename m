Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbTCKJXr>; Tue, 11 Mar 2003 04:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbTCKJXr>; Tue, 11 Mar 2003 04:23:47 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:59843 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262883AbTCKJXq>;
	Tue, 11 Mar 2003 04:23:46 -0500
Date: Tue, 11 Mar 2003 10:34:27 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Niels Provos <provos@citi.umich.edu>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030311093427.GA19658@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
	Marius Aamodt Eriksen <marius@citi.umich.edu>,
	Shailabh Nagar <nagar@watson.ibm.com>,
	Niels Provos <provos@citi.umich.edu>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 12:15:25PM -0800, Davide Libenzi wrote:

> 2) Existing apps using poll/select can easily be ported usinf LT epoll

This is a big thing. I created a webserver based on MTasker
(ds9a.nl/mtasker) that used select, poll or epoll and it was very hard to
abstract this properly as level and edge semantics differ so wildly.

Most programs will not abandon 'legacy' interfaces like poll and select and
will only want to offer epoll in addition. Right now that is hard to do.

I implemented this by 'relevelling' the edgeness of epoll, which is double
work.

> 1) We leave epoll as is ( ET )
> 2) We apply the patch that will make epoll LT
> 3) We add a parameter to epoll_create() to fix the interface behaviour at
> 	creation time ( small change on the current patch )
> 
> With 2) and 3) there are also man pages to be reviewed to be posted to
> Andries. Comments ?

I'd vote for 2.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
