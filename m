Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTIRLWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbTIRLWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:22:37 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:62987 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261156AbTIRLWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:22:35 -0400
Date: Thu, 18 Sep 2003 13:22:34 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo.tosatti@cyclades.com.br, pavel@ucw.cz, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030918112234.GA81495@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	marcelo.tosatti@cyclades.com.br, pavel@ucw.cz,
	alan@lxorguk.ukuu.org.uk, neilb@cse.unsw.edu.au,
	linux-kernel@vger.kernel.org
References: <20030916195345.GB68728@dspnet.fr.eu.org> <Pine.LNX.4.44.0309161814410.15569-100000@logos.cnet> <20030916212301.GC17045@m23.limsi.fr> <20030917131407.17f767a3.skraw@ithnet.com> <20030917130818.GA3144@m23.limsi.fr> <20030918095845.GA77609@dspnet.fr.eu.org> <20030918121327.5739b467.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918121327.5739b467.skraw@ithnet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 12:13:27PM +0200, Stephan von Krawczynski wrote:
> Fine. So we seem to agree 2.4.23 will be another big hit in the 2.4 line :-)

Indeed, it's working beautifully.


> > Now if only the CPU enumeration worked and both CPUs were detected...
> 
> Hm, I have not yet seen any configuration where multiple CPUs are not detected.
> Are you sure you have compiled in SMP support? What does dmesg look like?

I found the problem.  The meaning of the option "number of supported
CPUs" is not what is expected.  It is not fixing the maximum number of
CPUs, but the number of the last CPU checked for.  Specifically, in
our system the CPUs are numbered 0 and 6.  Setting the MNCPU to 2
prevents the second CPU to be taken into account.

  OG.

