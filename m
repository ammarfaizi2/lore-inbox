Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSIEPaN>; Thu, 5 Sep 2002 11:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSIEPaN>; Thu, 5 Sep 2002 11:30:13 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:36543 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317639AbSIEPaM>; Thu, 5 Sep 2002 11:30:12 -0400
Date: Thu, 5 Sep 2002 17:34:36 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Andrew Ryan <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ARP and alias IPs
Message-ID: <20020905153436.GG16092@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Andrew Ryan <genanr@emsphone.com>,
	linux-kernel@vger.kernel.org
References: <20020905150949.GA8112@thumper2.emsphone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905150949.GA8112@thumper2.emsphone.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 10:09:50AM -0500, Andrew Ryan wrote:
> The linux implementation of ARP is causing me problems.  Linux sends out an
> ARP request with the default interface as the sender address, rather than then
> interface the request came on. 

http://www.rfc-editor.org/rfc/std/std37.txt

> For example
> 
> eth0   10.1.1.100
> eth0:1 192.16.1.101 

Are you really expect an aliased interface to work the way you described?

> and an ARP is received on 192.16.1.101, linux responds with
> 10.1.1.100 as the source address in the ARP request, rather than 192.16.1.101
> (which FreeBSD, Solaris, and tru64 do).  To me, this is just plain wrong. 
> The sender address should be an address on the subnet that the request came
> from, not a different one.  Is there any way to fix this?
