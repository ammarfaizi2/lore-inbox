Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130634AbQKGMws>; Tue, 7 Nov 2000 07:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130642AbQKGMwi>; Tue, 7 Nov 2000 07:52:38 -0500
Received: from ns.dce.bg ([212.50.14.242]:33285 "HELO home.dce.bg")
	by vger.kernel.org with SMTP id <S130634AbQKGMw2>;
	Tue, 7 Nov 2000 07:52:28 -0500
Message-ID: <3A07FADF.D886D61F@dce.bg>
Date: Tue, 07 Nov 2000 14:51:43 +0200
From: Petko Manolov <petkan@dce.bg>
Organization: Deltacom Electronics
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "James A. Sutherland" <jas88@cam.ac.uk>, Dan Hollis <goemon@anime.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13t7yE-0007MV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > In the NIC example, I might well want the DHCP client to run whenever I
> > activate the card. Bringing the NIC up with the old configuration - which, with
> > dynamic IP addresses, could now include someone else's IP address! - is worse
> > than useless.
> 
> You'll notice the pcmcia subsystem already handles this, and keeps data in user
> space although it doesnt support saving it back. And it all works
> 
> In your case it would be something like
> 
> eth0    pegasus
> nopersist eth0
> post-install eth0 /usr/local/sbin/my-dhcp-stuff


Oops! Don't try to do this with pegasus.c older than 0.4.13.
I have set the ethernet address at open time, which breaks
dhcpd. I fixed that in test-10, but it's release took a long
time.

Sorry if the note doesn't make sense, i didn't follow the
thread from the beginning.


	Petkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
