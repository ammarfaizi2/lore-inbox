Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVIUOCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVIUOCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVIUOCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:02:50 -0400
Received: from Lodur.telex.com ([192.112.63.16]:5897 "EHLO lodur.telex.com")
	by vger.kernel.org with ESMTP id S1750964AbVIUOCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:02:50 -0400
In-Reply-To: <200509211653.17999.vda@ilport.com.ua>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: Bogomips on AMD X2 (was Re:)
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
From: Robert.Boermans@uk.telex.com
Message-ID: <OFB4729D93.721C31AE-ON80257083.004CBAE1-80257083.004D28F3@telex.com>
Date: Wed, 21 Sep 2005 15:02:51 +0100
X-MIMETrack: Serialize by Router on Passthru01/Telex(652HF636|November 23, 2004) at 09/21/2005
 09:02:49 AM,
	Serialize complete at 09/21/2005 09:02:49 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I noticed that the bogomips results for the two cores on my machine 
are 
> > consistently not the same, the second one is always reported slightly 
> > faster, it's a small difference and I saw the same in a posted dmesg 
> from 
> > somebody else on the list. Which made me wonder: 
> 
> I guess it's a cache warming effect. Please show the numbers.
>
> Probably not, got this one from a web site, and on this one the first 
core 
> seems to be faster (can't check my own machine it's off and at home and 
> I'm at work.) The difference I get is similar, but always with the 
second 
> one faster. It's the same when using cat on /proc/cpuinfo. Oh and I saw 
it 
> on 2.6.11 and 2.6.12 as supplied with fedora core 4 myself.
> 
> Calibrating delay using timer specific routine.. 4014.73 BogoMIPS 
> (lpj=8029470)
...
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4005.37 BogoMIPS 
> (lpj=8010751)

Why do you think it cannot be a cache warming effect?
--
vda

----------
Because with this one the first case was the faster one, that would need 
cache cooling :)
But besides that, as far as I remember the actual loop is about 3 
instructions long and will be cache hot in a time that you'd never notice 
in the end result.

Sorry about the formatting, but it's lotus notes :/
