Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTIPOh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTIPOh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:37:56 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:13989 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261928AbTIPOhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:37:53 -0400
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030916153658.3081af6c.skraw@ithnet.com>
References: <20030916102113.0f00d7e9.skraw@ithnet.com>
	 <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>
	 <20030916153658.3081af6c.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Tue, 16 Sep 2003 15:36:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-16 at 14:36, Stephan von Krawczynski wrote:
> Well, I do understand the bounce buffer problem, but honestly the current way
> of handling the situation seems questionable at least. If you ever tried such a
> system you notice it is a lot worse than just dumping the additional ram above
> 4GB. You can really watch your network connections go bogus which is just
> unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> do something useful with the beyond-4GB ram parts?

The 2.6 tree is somewhat better about this but at the end of the day if
your I/O subsystem can't do the job your box will not perform ideally.
For some workloads its a huge win to have the extra RAM, for others the
I/O is a real pain. Also in some cases it might be interesting to try
using the extra RAM above the 4G boundary as a giant ram disk and using
it as first swap device.

I don't know anyone who explored that however


