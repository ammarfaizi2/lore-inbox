Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284613AbRLEThr>; Wed, 5 Dec 2001 14:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284616AbRLEThm>; Wed, 5 Dec 2001 14:37:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56317
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284613AbRLEThD>; Wed, 5 Dec 2001 14:37:03 -0500
Date: Wed, 5 Dec 2001 11:36:57 -0800
To: Steve Parker <sparker@sparker.net>
Cc: Kurt Roeckx <Q@ping.be>, Tim Hockin <thockin@sun.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com
Subject: Re: [PATCH] eepro100 - need testers
Message-ID: <20011205193657.GC9050@mikef-linux.matchmail.com>
Mail-Followup-To: Steve Parker <sparker@sparker.net>,
	Kurt Roeckx <Q@ping.be>, Tim Hockin <thockin@sun.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	arjanv@redhat.com, saw@sw-soft.com
In-Reply-To: <3C0D54DF.4E897B70@sun.com> <E167w6n-0001dz-00@fenrus.demon.nl> <3C0D54DF.4E897B70@sun.com> <4.2.2.20011205085135.00ab0e88@slither>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.2.2.20011205085135.00ab0e88@slither>
User-Agent: Mutt/1.3.24i
From: Mike Fedyk <mfedyk@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 08:59:45AM -0800, Steve Parker wrote:
> At 05:26 PM 12/4/2001 , Kurt Roeckx wrote:
> >On Tue, Dec 04, 2001 at 02:57:35PM -0800, Tim Hockin wrote:
> >> -#define TX_RING_SIZE 32
> >> -#define RX_RING_SIZE 32
> >> +#define TX_RING_SIZE 64
> >> +#define RX_RING_SIZE 1024
> >
> >Why do I have the feeling that you're just changing those values
> >so you get less chance of having the problem?  Are there any
> >other reason why you change this?  It might even be a good idea
> >to test it with lower values.
> 
> If you test with lower values, I find that the problem happens so often that
> bidirectional TCP bulk throughput tests on 100Mbits/sec ethernet are 
> significantly
> lower.  As Tim pointed out, the RX ring size is chosen based on being large 
> enough
> to receive steadily and only require the ISR to come by and empty it once 
> every jiffy.
> In order to provide good performance and survivability on maximum packet 
> rate loads,
> it needs to be 1024, although it's moderately good on 512, on my 300MHz K6 
> system.
> 

So, if I choose to plug an eepro100 into a pentium 75 (or comperable on
other pci based arch), am I going to get massive RX_RING overflows?  If so,
then the ring size should probably be sized based on bogomips...

mf
