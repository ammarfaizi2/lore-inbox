Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264742AbSJOUfi>; Tue, 15 Oct 2002 16:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbSJOUfZ>; Tue, 15 Oct 2002 16:35:25 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:760 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264742AbSJOUeD>; Tue, 15 Oct 2002 16:34:03 -0400
Date: Tue, 15 Oct 2002 16:39:58 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015163958.E16156@redhat.com>
References: <20021015150201.K14596@redhat.com> <Pine.LNX.4.44.0210151213170.1554-100000@blue1.dev.mcafeelabs.com> <20021015151238.L14596@redhat.com> <3DAC7C56.6020104@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC7C56.6020104@netscape.com>; from jgmyers@netscape.com on Tue, Oct 15, 2002 at 01:36:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 01:36:38PM -0700, John Gardiner Myers wrote:
> Benjamin LaHaise wrote:
> 
> >Erm, the aio interface has support for the event ringbuffer being accessed 
> >by userspace
> >
> Making the event ringbuffer visible to userspace conflicts with being 
> able to support event priorities.  To support event priorities, the 
> ringbuffer would need to be replaced with some other data structure.

No it does not.  Event priorities are easily accomplished via separate 
event queues for events of different priorities.  Most hardware implements 
event priorities in this fashion.

		-ben
-- 
"Do you seek knowledge in time travel?"
