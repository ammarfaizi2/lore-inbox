Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTEaPIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTEaPIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:08:20 -0400
Received: from main.gmane.org ([80.91.224.249]:12945 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264460AbTEaPIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:08:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
Date: Sat, 31 May 2003 11:21:39 -0400
Message-ID: <pan.2003.05.31.15.21.38.863368@interlinx.bc.ca>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca> <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com> <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca> <Pine.LNX.4.50.0305301907230.29718-100000@montezuma.mastecende.com> <pan.2003.05.31.03.38.16.701826@interlinx.bc.ca> <pan.2003.05.31.04.41.25.903565@interlinx.bc.ca> <Pine.LNX.4.50.0305310246250.31414-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 02:50:35 -0400, Zwane Mwaikambo wrote: 
> 
> The following patch will honour the dont_enable_local_apic flag in the 
> necessary places. If it works for you i'll forward it.

Yesserrie, it works, assuming dont_enable_local_apic gets set to "1"
somewhere, somehow.  In the case of broken hardware (or a broken emulation
of it, like VMware 2.0.4) however, a command line arg (such as the nolapic
patch you posted previously) is still needed to disable the local apic in
the case where there is no DMI information that can be used to add the
broken system to the blacklist.

A combination of your previous nolapic patch and this one you just posted
would do the trick indeed.

Thanx much!

b.



