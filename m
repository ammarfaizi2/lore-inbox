Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281202AbRLAARt>; Fri, 30 Nov 2001 19:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281205AbRLAARj>; Fri, 30 Nov 2001 19:17:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58108
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281202AbRLAARZ>; Fri, 30 Nov 2001 19:17:25 -0500
Date: Fri, 30 Nov 2001 16:17:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nathan Poznick <poznick@conwaycorp.net>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Andrey V. Savochkin" <saw@saw.sw.com.sg>
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011130161717.G504@mikef-linux.matchmail.com>
Mail-Followup-To: Nathan Poznick <poznick@conwaycorp.net>,
	linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Andrey V. Savochkin" <saw@saw.sw.com.sg>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com> <20011130114506.A4789@bee.lk> <15367.44557.930845.66428@abasin.nj.nec.com> <20011130163131.A12298@conwaycorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130163131.A12298@conwaycorp.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added Jeff & Andrey to cc list because they were the last two to modify the
driver according to the comments at the top of eepro100.c

On Fri, Nov 30, 2001 at 04:31:31PM -0600, Nathan Poznick wrote:
> Thus spake Sven Heinicke:
> > 
> > I have eepro100's on other systems and never had a problem.  They
> > never have been made to work as hard as the DELLs though.  I am
> > trying the same DELL with a 3C996-T 1000Bt card using the driver from
> > 3COM (we plan on moving that system to a 1000Bt system but the switch
> > hasn't arrived yet) and it is running at 100Bt with the same
> > software.  If you don't hear form me assume it surrived.  Been up a
> > day so far, took the DELL like 3 days of heavy use to crash before.
> 
> Ok, I finally had a chance to work on this, and here's what I know:
> 
> 1) I found a workload under which I was able to reliably make the
> network on the machine die (a few hundred of the "eth0: card reports
> no resources." errors showed up which continued until I took down the
> network and removed the module).  Unfortunately, the workload was with
> an in-house app, so all I can describe are the conditions associated
> with it: 2 processes with a total of about 600 threads, 1.5gb of
> memory, about 500 network connections, and a lot of disk and network
> I/O. 
> 
You can run the test against eepro100 with tcpdump redirected to a log file,
and post that on the web somewhere.  That would probably be helpful.

Also, some sort of profiling.

Jeff, Andrey, can you comment?
