Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSIEWfp>; Thu, 5 Sep 2002 18:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSIEWfp>; Thu, 5 Sep 2002 18:35:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51668 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318742AbSIEWfo>;
	Thu, 5 Sep 2002 18:35:44 -0400
Message-ID: <1031265571.3d77dd23caec4@imap.linux.ibm.com>
Date: Thu,  5 Sep 2002 15:39:31 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: Troy Wilson <tcw@tempest.prismnet.com>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <200209052211.g85MBFdm099387@tempest.prismnet.com>
In-Reply-To: <200209052211.g85MBFdm099387@tempest.prismnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.20.67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Troy Wilson <tcw@tempest.prismnet.com>:

> > Do you have any stats from the hardware that could show
> > retransmits etc;
> 
>   I'll gather netstat -s after runs with and without TSO enabled.
> Anything else you'd like to see?

Troy, this is pointing out the obvious, but make sure
you have the before stats as well :)...

> > have you tested this with zero copy as well (sendfile)
> 
>   Yes.  My webserver is Apache 2.0.36, which uses sendfile for
> anything
> over 8k in size.  But, iirc, Apache sends the http headers using
> writev.

SpecWeb99 doesnt execute the path that might benefit the 
most from this patch - sendmsg() of large files - large writes
going down..

thanks,
Nivedita


