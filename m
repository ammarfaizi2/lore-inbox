Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTJNKk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJNKk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:40:57 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:9920 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S262321AbTJNKkl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:40:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Richard J Moore <rasman@uk.ibm.com>
Organization: Linux Technoilogy Centre - RAS team
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Date: Tue, 14 Oct 2003 11:32:28 +0000
User-Agent: KMail/1.4.1
Cc: karim@opersys.com, jmorris@redhat.com, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com> <200310122323.48885.rasman@uk.ibm.com> <20031013102520.0671a69d.davem@redhat.com>
In-Reply-To: <20031013102520.0671a69d.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310141132.28339.rasman@uk.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting, that assumes sequential processing, if not semi-synchronous 
processing of events on the receiver side, which is far from guaranteed when 
considering low-level tracing especially for flight-recorder applications.  
relayfs is specifically targeted at situations where there is no implied 
synchronisation or protocol between server and clients. Indeed, where the 
receiver is undefined at the time the data is deposited.

-- 
Richard J Moore
IBM Linux Technology Centre

On Mon 13 October 2003 5:25 pm, David S. Miller wrote:
> On Sun, 12 Oct 2003 23:23:48 +0000
>
> Richard J Moore <rasman@uk.ibm.com> wrote:
> > Why is a queuing model relvant to low-level kernel tracing, which is the
> > prime target of relayfs?
>
> Because you need a queueing model any time there is a sender of
> information and a receiver.  In this case it's the kernel events
> and the event logging process.


