Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269512AbRHCRXC>; Fri, 3 Aug 2001 13:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269491AbRHCRWw>; Fri, 3 Aug 2001 13:22:52 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:4329 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S269505AbRHCRWd>; Fri, 3 Aug 2001 13:22:33 -0400
Date: Fri, 3 Aug 2001 13:22:25 -0400
From: "Bill Rugolsky Jr." <brugolsky@yahoo.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803132225.A17033@ead45>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010803155255.X12470@redhat.com> <15210.48950.179949.657793@pizda.ninka.net> <01080317250906.01827@starship> <20010803130601.A12695@ead45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010803130601.A12695@ead45>; from rugolsky@ead.dsa.com on Fri, Aug 03, 2001 at 01:06:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 01:06:01PM -0400, Bill Rugolsky Jr. wrote:
> 	ln tmp/x peek/x

In fact, make that

	ln tmp/x peek/x
			<- MTA does the fsync()
	less peek/x
			<- MTA closes the file.
	rm peek/x
		     (peek gets written asynchronously to disk)
	*CRASH*
                           
Then we are back to "lost+found", nothing gained.

Regards,

   Bill Rugolsky
