Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319181AbSIDPqc>; Wed, 4 Sep 2002 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319199AbSIDPqb>; Wed, 4 Sep 2002 11:46:31 -0400
Received: from orion.netbank.com.br.199.203.200.in-addr.arpa ([200.203.199.90]:7173
	"EHLO orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S319181AbSIDPqU>; Wed, 4 Sep 2002 11:46:20 -0400
Date: Wed, 4 Sep 2002 12:50:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X.25 Support in Kernel?
Message-ID: <20020904155042.GA4427@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <al4ihm$h34$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al4ihm$h34$1@forge.intermeta.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 04, 2002 at 09:08:06AM +0000, Henning P. Schmiedehausen escreveu:

> Considering the possibility of hacking with the x.25 part of the kernel;
> which would be the best way to start with LLC2 support? Using the driver
> from linux-sna or hacking with net/llc ?

The "driver" from linux-sna is the code I'm working on (based on code donated
by Procom, inc) that nowadays sits in net/llc in 2.5, IOW, its the same code.
I'm still doing lots of modifications on the net/llc code, as I'm still not
satisfied with the socket locking mess that is there because the
net/llc/llc_sock.c (llc_ui, PF_LLC, BSD sockets interface with userlevel) is
using a struct sock and the core is using another, but now that I'm back from
vacation I'm working on fixing this, making it look a lot more like the tcp/ip
codepaths in the kernel, so, if you are interested in going in this direction,
I'm interested in test results, etc.

Maybe adapting the XOT code to do userspace X.25 over a PF_LLC socket could
do it :)

- Arnaldo
