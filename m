Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSFRWn4>; Tue, 18 Jun 2002 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSFRWnz>; Tue, 18 Jun 2002 18:43:55 -0400
Received: from pcp809261pcs.nrockv01.md.comcast.net ([68.49.81.201]:4586 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S317653AbSFRWny>;
	Tue, 18 Jun 2002 18:43:54 -0400
Date: Tue, 18 Jun 2002 18:43:56 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about sched_yield()
Message-ID: <20020618184356.A24581@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <AMEKICHCJFIFEDIBLGOBEEEHCBAA.mgix@mgix.com> <20020618180154.AAA21943@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020618180154.AAA21943@shell.webmaster.com@whenever>; from davids@webmaster.com on Tue, Jun 18, 2002 at 11:01:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 11:01:53AM -0700, David Schwartz wrote:
> 	Your assumptions are just plain wrong. The yielder is being nice, so it 
> should get preferential treatment, not worse treatment.

Heh?  Yielding is not about being nice, if you want to be nice you
lower your priority.  Yielding is telling the scheduler "I am
temporarily out of things to do, maybe for a while, but a least until
all the others running threads got a chance to run too".  Any
scheduler that runs you immediatly again without running the others
threads is _broken_.

  OG.
