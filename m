Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSBVIhm>; Fri, 22 Feb 2002 03:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292838AbSBVIhX>; Fri, 22 Feb 2002 03:37:23 -0500
Received: from host213-121-106-53.in-addr.btopenworld.com ([213.121.106.53]:6391
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S292837AbSBVIhO>; Fri, 22 Feb 2002 03:37:14 -0500
Subject: Re: is CONFIG_PACKET_MMAP always a win?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: "David S. Miller" <davem@redhat.com>, dank@kegel.com,
        linux-kernel@vger.kernel.org, zab@zabbo.net
In-Reply-To: <3C75E905.9000809@candelatech.com>
In-Reply-To: <3C75A418.2C848B3F@kegel.com>
	<20020221.215925.41634293.davem@redhat.com> 
	<3C75E905.9000809@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 22 Feb 2002 08:37:12 +0000
Message-Id: <1014367033.13551.1.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-22 at 06:45, Ben Greear wrote:
> 
> 
> David S. Miller wrote:
> 
> >    From: Dan Kegel <dank@kegel.com>
> >    Date: Thu, 21 Feb 2002 17:51:20 -0800
> > 
> >    What's the best way to retrieve raw packets from the kernel?
> >    
> >    a) use libpcap
> >  ...   
> >    b) use af_packet
> >  ...   
> >    c) enable CONFIG_PACKET_MMAP, use PACKET_RX_RING
> >    
> >    If I understand it right, b costs one memcpy and one recv, and c costs
> >    two memcpys.  Which one wins?
> > 
> > "a" should be doing "c" when it is available in the kernel.
> > If not, get a newer copy of the libpcap sources, preferably
> > from Alexey's site:
> > 
> > ftp.inr.ac.ru:/ip-routing/
> 
> 
> And if you can figure out how to do c, and feel like
> sharing, please do let me know!  Documentation is a
> bit sparse..at least wherever I've been looking.

Yeah I found it a bit lacking too, I got there in the end though. Check
out: http://www.scaramanga.co.uk/code-fu/lincap.c

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
80% of all email is a figment of procmails imagination.

