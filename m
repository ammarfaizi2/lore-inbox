Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271587AbRICPLa>; Mon, 3 Sep 2001 11:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271589AbRICPLV>; Mon, 3 Sep 2001 11:11:21 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:60679 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S271587AbRICPLF>; Mon, 3 Sep 2001 11:11:05 -0400
Message-ID: <3B939DBA.B14FC2CF@loewe-komp.de>
Date: Mon, 03 Sep 2001 17:11:54 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: psusi@cfl.rr.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states
In-Reply-To: <01090310483100.26387@faldara>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> 
[ "mount -tnfs" with hard has default ]
 
> Anyhow, about an hour later ( the mount process still stuck ) I figured out
> that the other machine was not running rpc.nfsd, though it was running
> rpc.mountd.  Once I started rpc.nfsd on the machine, the mount on my box
> finally returned ( and was terminated by the SIGKILL that I sent it an hour
> before ).
> 
> Could someone confirm that this is a bug, and explain why anything should
> ever need to wait in that state?
> 
Well, if you use the option "soft",then your process is interruptible.
>From a user standpoint, I don't understand the requirement of 'D' state.

Where this gets really impractical: commands like df or du will
hang forever (if the other end is out of your control).
