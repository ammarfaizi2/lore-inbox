Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUDVOkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUDVOkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbUDVOkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:40:09 -0400
Received: from dsl-gw-90.pilosoft.com ([69.31.90.1]:24538 "EHLO
	paix.pilosoft.com") by vger.kernel.org with ESMTP id S264073AbUDVOkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:40:03 -0400
Date: Thu, 22 Apr 2004 10:37:42 -0400 (EDT)
From: alex@pilosoft.com
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <1082644022.1099.40.camel@jzny.localdomain>
Message-ID: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2004, jamal wrote:

> Unless its a private network with locked vaults for the pipes, any
> network is vulnerable. I am not trying to downplay the relevance of
> this; all i am saying is it may a little overhyped with the media being
> involved. Its infact harder to create this attack compared to a simple
> SYN attack.
Not quite. With a SYN you have to respond with exactly the same sequence 
number as attacking host in order to establish connection. With RST, your 
sequence number needs to be +- rwin in order to kill the connection. That 
significantly reduces search space.

> Unless i misunderstood: You need someone/thing to see about 64K packets
> within a single flow to make the predicition so the attack is succesful.
> Sure to have access to such capability is to be in a hostile path, no?
> ;->
No, you do not need to see any packet. 

> > And it's not BGP specific.  You might be able to use this attack to
> > split IRC networks, too.  However, it's a bit harder in this case
> > because IRC servers usually use more random source ports.
> 
> Any long lived flow with close to fixed ports. FTP from kernel.org could
> be vulnerable - get a better client and its just becomes a nuisance. 80%
> of the internet traffic is still TCP/HTTP1.0 which is very short lived
> (there could be changes lately - these are numbers from a while back)
> i.e you wont see more than 8 packets i.e it is highly unlikely your
> traffic there is affected even if you used fixed ports.
Inter-provider BGP is long-lived with close to fixed ports, which is why 
it has caused quite a stir.

Nevertheless, number of packets to kill the session is still *large* 
(under "best-case" for attacker, you need to send 2^30 packets)...

-alex

