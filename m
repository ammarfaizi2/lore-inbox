Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbTCHT2q>; Sat, 8 Mar 2003 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbTCHT2q>; Sat, 8 Mar 2003 14:28:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27406 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262141AbTCHT2p>;
	Sat, 8 Mar 2003 14:28:45 -0500
Date: Sat, 8 Mar 2003 11:29:08 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Andries.Brouwer@cwi.nl,
       alan@lxorguk.ukuu.org.uk, akpm@digeo.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308192908.GB26374@kroah.com>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308073407.A24272@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 07:34:07AM +0000, Christoph Hellwig wrote:
> On Fri, Mar 07, 2003 at 04:53:33PM -0800, Greg KH wrote:
> > driver asks for a major, today it only thinks it has 256 minors, so that
> > number is usually hard coded in an array.  If a open() happens on a
> > minor outside that range, the driver will die a horrible death, right?
> 
> Yes.  That's why the character device code should get a similar massaging
> as the block layer code got in 2.5.  But I don't really see this happen
> in the 2.6 timeframe, especially given that there are a lot more character
> than block drivers.

I agree, I thought this was a 2.7 change, but it's looking like people
want this change sooner :)

greg k-h
