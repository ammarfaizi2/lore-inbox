Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131463AbRCNQaB>; Wed, 14 Mar 2001 11:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRCNQ3w>; Wed, 14 Mar 2001 11:29:52 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:31782 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131463AbRCNQ3b>; Wed, 14 Mar 2001 11:29:31 -0500
Message-ID: <3AAF9BF3.B3DB8948@mvista.com>
Date: Wed, 14 Mar 2001 08:27:31 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, npsimons@fsmlabs.com,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.LNX.4.33.0103141618320.21132-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 14 Mar 2001, george anzinger wrote:
> 
> > Is it REALLY necessary to prevent them from seeing an
> > inconsistent state?  Seems to me that in the total picture (i.e.
> > system wide) they will never see a consistent state, so why be
> > concerned with a small corner of the system.
> 
> You're right. All we need to make sure of is that the address
> space we want to print info about doesn't go away while we're
> reading the stats ...
> 
> (I think ... but we'll need to look at the procfs code in more
> detail)
> 
For what its worth:
On the last system I worked on we had a status program that maintained a
screen with interesting things such as context switches per sec, disc
i/o/sec, lan traffic/sec, ready queue length, next task (printed as
current task) and... well a whole 26X80 screen full of stuff.  The
program gathered all the data by reading system tables as quickly as
possible and THEN did the formatting/ screen update.  Having to deal
with pre formatted data would have a.) widened the capture window and
b.) been a real drag to reformat and move to the right screen location. 
We allowed programs that had the savvy to have read only access to the
kernel area to make this as fast as possible.

George
