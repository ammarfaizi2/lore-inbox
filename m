Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTISNeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTISNeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:34:19 -0400
Received: from gw-nl4.philips.com ([212.153.190.6]:63970 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S261563AbTISNeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:34:18 -0400
Message-ID: <3F6B05ED.7020802@basmevissen.nl>
Date: Fri, 19 Sep 2003 15:34:37 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resuming from software suspend
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net> <1063958370.5520.6.camel@laptop-linux> <yw1xu179mc55.fsf@users.sourceforge.net> <1063963914.7253.9.camel@laptop-linux> <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net> <1063965939.7874.6.camel@laptop-linux> <yw1xoexhkrtb.fsf@users.sourceforge.net>
In-Reply-To: <yw1xoexhkrtb.fsf@users.sourceforge.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> What I want to do is boot, do some things, and then resume the
> suspended state without rebooting between.  Is that possible?  I don't
> see any reason why it should be impossible to do, even if it's not
> currently supported.
> 

Just after booting, you know the state of the hardware (just initialised 
for most things that are not used to /boot/start resume/ from). You need 
to get the hardware in a sort of just-booted state before revering to 
the swsusp image you saved earlier because the drivers (might) expect 
the hardware to be in a certain state when they are started up by swsusp.

So you have to be carefull about the hardware (and not only the 
filesystem) state just before reverting to the swsusp image.

Bas.



