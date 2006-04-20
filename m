Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDTJDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDTJDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDTJDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:03:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37032 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750761AbWDTJDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:03:07 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Subject: Re: select takes too much time
Date: Thu, 20 Apr 2006 12:01:50 +0300
User-Agent: KMail/1.8.2
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com> <20060413153028.GA26480@rhlx01.fht-esslingen.de> <728201270604130911y4adf9967kd38712e731161074@mail.gmail.com>
In-Reply-To: <728201270604130911y4adf9967kd38712e731161074@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604201201.50981.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 19:11, Ram Gupta wrote:
> On 4/13/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > Hi,
> >
> > Now if you have issues with select() taking too long, then I'd say tough
> > luck, that's life, other processes seem more important than y
> >
> > Or, to put it differently, select() doesn't have realtime guarantees, i.e.
> > there's no way for you to boldly assume that once select() times out
> > your process will continue to run instantly within microseconds.
> 
> I was not expecting it to run instantly within microseconds but 1
> second seemed to me too much

Which processes are running on your system?

Try to stop almost all processes and retest on almost idle machine.
It is works (wakes up in 90ms) then all is working as designed.

If you want select() to wake up earlier than competing
processes, you have to inform scheduler that your task
is "more important". Use "nice" for that.
--
vda
