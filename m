Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVDKShy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVDKShy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDKShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:37:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51963 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261878AbVDKShr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:37:47 -0400
Subject: Re: RT and Signals
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: john cooper <john.cooper@timesys.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <425ABC01.2020100@timesys.com>
References: <1113239666.30549.37.camel@dhcp153.mvista.com>
	 <425ABC01.2020100@timesys.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113244656.30553.55.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Apr 2005 11:37:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 11:03, john cooper wrote:
> Daniel Walker wrote:
> > 	I'm not sure if this has changed at all in recent RT patches, but I've
> > noticed several issues popping up that are related to the timer
> > interrupt sending signals...
> 
> I've also seen BUG asserts kicking in on PPC (40-04-ish) in
> signal delivery [actual receipt] paths.  These have only been
> under fairly heavy load conditions and presumably is hitting
> an infrequent path in force_sig_info() IIRC.  Haven't had the
> time yet to resolve these but they are on the list.

	Ingo's solution was to remove the signal delivery from the timer
interrupt altogether. Which I don't know if that's acceptable. It seems
like there is a never ending stream of bugs related to this..

Daniel

