Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbQKPRtB>; Thu, 16 Nov 2000 12:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131200AbQKPRsv>; Thu, 16 Nov 2000 12:48:51 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23312 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131142AbQKPRsn>;
	Thu, 16 Nov 2000 12:48:43 -0500
Date: Thu, 16 Nov 2000 18:18:40 +0100
From: Andi Kleen <ak@suse.de>
To: Nishant Rao <nishant@cs.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Setting IP Options in the IP-Header
Message-ID: <20001116181840.A18222@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0011161111210.5572-100000@crom.cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011161111210.5572-100000@crom.cs.utexas.edu>; from nishant@cs.utexas.edu on Thu, Nov 16, 2000 at 11:11:45AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 11:11:45AM -0600, Nishant Rao wrote:
> Hi,
> 
> We are conducting some research that involves setting our custom data as
> a new IP option in the IP header (in the options field) of every packet.
> 
> We have poured over the source code but it is quite confusing to figure
> out how the details of the way the options field is split among various
> options (ie. offsets etc). Can anyone help us figure out how to add new
> custom options into the IP header ? 

man ip(7), see the IP_OPTIONS socket option.

Linux only echoes received options, but never sets them by default unless that 
socket option is specified. So it depends on the application and/or the sender.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
