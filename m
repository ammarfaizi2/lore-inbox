Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWINWqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWINWqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWINWqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:46:23 -0400
Received: from dvhart.com ([64.146.134.43]:7138 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932089AbWINWqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:46:22 -0400
Message-ID: <4509DBBD.6000304@mbligh.org>
Date: Thu, 14 Sep 2006 15:46:21 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu> <4509B5A4.2070508@mbligh.org> <20060914201448.GA7357@elte.hu> <1158267906.5068.49.camel@localhost> <20060914222318.GA25004@elte.hu>
In-Reply-To: <20060914222318.GA25004@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i disagree. Consider the following example from LTT:
...
>          trace_socket_sendmsg(sock, sock->sk->sk_family,
>                  sock->sk->sk_type,
>                  sock->sk->sk_protocol,
>                  size);
...

> what do the 5 extra lines introduced by trace_socket_sendmsg() tell us? 
> Nothing. They mostly just duplicate the information i already have from 
> the function declaration. They obscure the clear view of the function:
  ...
> the resulting visual and structural redundancy hurts.

Couldn't that be easily fixed by just doing

	trace_socket_sendmsg(sock, size);

and have it work out which esoteric parts of the sock we want to trace,
and which we don't? Is much less visually invasive, and gives the same
effect.

M.


