Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275627AbRJAWDy>; Mon, 1 Oct 2001 18:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275624AbRJAWDo>; Mon, 1 Oct 2001 18:03:44 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:42245 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S275616AbRJAWDd>; Mon, 1 Oct 2001 18:03:33 -0400
Date: Mon, 1 Oct 2001 18:04:00 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Thomas Davis <tadavis@lbl.gov>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: endless APIC error messages..
In-Reply-To: <3BB8DCD5.A2CF293D@lbl.gov>
Message-ID: <Pine.LNX.4.10.10110011800400.13303-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running 2.4, I get thousands of the APIC error messages, which fill my
> syslog.
> 
> Is there a reason for this constant spewing?  The short little patch,

yes: any machine with enough apic errors to annoy
is a machine that is *not* catching all corrupt apic messages.
you don't want that.  if you want any patch at all, have it panic() 
if it ever sees, say, two apic errors per jiffy.  

your patch is about like removing the battery from your smoke alarm...

