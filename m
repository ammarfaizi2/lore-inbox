Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270712AbRIJLxY>; Mon, 10 Sep 2001 07:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270657AbRIJLxO>; Mon, 10 Sep 2001 07:53:14 -0400
Received: from t2.redhat.com ([199.183.24.243]:34806 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S270646AbRIJLxC>; Mon, 10 Sep 2001 07:53:02 -0400
Message-ID: <3B9CA9AE.DE0BD28F@redhat.com>
Date: Mon, 10 Sep 2001 12:53:18 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6.4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Developing code for ia64
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27313@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> Hi,
> 
> When developing kernel drivers (module) for ia64, is it necessary to do it
> on an ia64 machine ?
> Our product contains a pre-compiled core object (IP protection :-\ ) and a
> set of wrapper source files, so for dual platform support the tar ball has
> to contain both an ia32 and ia64 versions of the executable. Is there any
> way to get an ia64 compiler (and libs) installed on an ia32 machine and use
> it to get ia64 compatible binaries ?

I would seriously recommend to intel to consider NOT doing this. Binary
only modules 
are generally frowned upon and there is (almost) never a good reason for
doing
them. If you're concerned about firmware, that's a totally different
issue,
binary firmware images can be done in a much simpler way.

But PLEASE don't do such a binary only module; I thought Intel was more 
Open Source friendly than that. (And I know most parts of Intel are; the
CPU folks and the networking folks are VERY helpful)

For one, almost no Linux distribution will ship with your drivers so
customers 
have go to a lot of hassle to compile their own drivers, and by doing
that
they loose all support from the community.

Greetings,
   Arjan van de Ven
