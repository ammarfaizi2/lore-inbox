Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUAUPHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 10:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUAUPHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 10:07:53 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:43907 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265470AbUAUPHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 10:07:51 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Date: Wed, 21 Jan 2004 16:07:45 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.01.21.15.07.41.978972@smurf.noris.de>
References: <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com> <400DFC8B.7020906@cyberone.com.au> <20040121103933.B3236@in.ibm.com> <20040121070844.GA31807@hockin.org>
NNTP-Posting-Host: hyper.noris.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1074697665 1956 62.128.1.62 (21 Jan 2004 15:07:45 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Wed, 21 Jan 2004 15:07:45 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tim Hockin wrote:

> We already can not handle unexpected CPU removals gracefully, correct?  So
> we expect some user-provided notification, right?
> 
Well, if the CPU is executing userland (or idling), we conceivably could.
That would kill off one userspace process (which might be able to recover
given a signal and longjmp(), but such is life. ;-)

> So force userland to handle it before we give the OK to remove a CPU.

I like the idea of an "unrunnable" queue, that way you have the option to
fix the problem afterwards -- or just ignore it, if you decide it's OK for
processes to wait a few minutes while you replace the failing CPU fan.

It's like mount(). Usually you unmount cleanly, but sometimes you use -f
and something becomes inaccesible. At least WRT CPUs, the inaccessibility
is (usually) fixable. (I wish it were so, WRT NFS mounts.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Whenever the civil government forbids the practice of things
 that God has commanded us to do, or tells us to do things He
 has commanded us not to do then we are on solid ground in
 disobeying the government and rebelling against it."
               [Pat Robertson]

