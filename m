Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261673AbSIXNrX>; Tue, 24 Sep 2002 09:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbSIXNrX>; Tue, 24 Sep 2002 09:47:23 -0400
Received: from pc-62-30-72-148-ed.blueyonder.co.uk ([62.30.72.148]:63362 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261673AbSIXNrW>; Tue, 24 Sep 2002 09:47:22 -0400
Date: Tue, 24 Sep 2002 14:52:25 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] adding aio_readv/writev
Message-ID: <20020924145225.J3160@redhat.com>
References: <3D8B878C.8070503@watson.ibm.com> <1032555981.2082.10.camel@dell_ss3.pdx.osdl.net> <3D8F256D.1070107@watson.ibm.com> <20020923114104.A11680@redhat.com> <3D9066AD.6030904@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9066AD.6030904@netscape.com>; from jgmyers@netscape.com on Tue, Sep 24, 2002 at 06:20:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 24, 2002 at 06:20:45AM -0700, John Gardiner Myers wrote:
 
> Benjamin LaHaise wrote:
> 
> >Only db2 uses vectored io heavily.  Oracle does not, and none of the open 
> >source databases do.  Vectored io is pretty useless for most people.
> >  
> >
> writev is extremely important for networking as it avoids small packets.

No, all you can infer from that is that "some method for avoiding
small packets is important for networking."  TCP_CORK already does
that in Linux, for tcp at least, without requiring writev.  (Of
course, normal nonblocking writev is still there if you want it.)

--Stephen
