Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbSKDBed>; Sun, 3 Nov 2002 20:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264616AbSKDBed>; Sun, 3 Nov 2002 20:34:33 -0500
Received: from holomorphy.com ([66.224.33.161]:45969 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264613AbSKDBec>;
	Sun, 3 Nov 2002 20:34:32 -0500
Date: Sun, 3 Nov 2002 17:39:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021104013937.GQ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hch@lst.de, Benjamin LaHaise <bcrl@redhat.com>
References: <20021104003906.GB12891@holomorphy.com> <Pine.LNX.4.44.0211031731270.954-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031731270.954-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 05:39:29PM -0800, Davide Libenzi wrote:
> It's not realy a graph Bill.  Each task has a list of acquired locks (
> by address ). You keep __LINE__ and __FILE__ with you list items. When
> there's a deadlock you'll have somewhere :
>    TSK#N	TSK#M
>    -------------
>    ...		...
>    LCK#I	LCK#J
>    ...		...
> -> LCK#J	LCK#I
> Then with a SysReq key you dump the list of acquired locks for each task
> who's spinning for a lock. IMO it might be usefull ...

Then you had something different in mind. I *thought* you meant
maintaining a graph's arcs and dumping the specific deadlocking
processes and their acquired locks at failure time. This scheme
with limited reporting requires less work/code, but is still beyond
the scope of what I was doing.


Bill
