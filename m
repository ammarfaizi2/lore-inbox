Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJNPM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJNPM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJNPMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 11:12:55 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:47135 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265697AbUJNPMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 11:12:54 -0400
Message-ID: <81b0412b0410140812251110bb@mail.gmail.com>
Date: Thu, 14 Oct 2004 17:12:54 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Johan Kullstam <kullstj-ml@comcast.net>
Subject: Re: unkillable process
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87r7o1h4f3.fsf@sophia.axel.nom>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1097731227.2666.11264.camel@cube> <87r7o1h4f3.fsf@sophia.axel.nom>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Oct 2004 08:26:08 -0400, Johan Kullstam <kullstj-ml@comcast.net> wrote:
> Albert Cahalan <albert@users.sf.net> writes:
> 
> > It's really bad when a task group leader exits.
> > The process becomes unkillable.
> 
> I have been having zombie problems since 2.6.9-rc1.  I run a boinc
> climateprediction program (related to seti@home) which leaves defunct
> "cp" processes about.  Killing the climatepredictor (called
> hadsm3um_4.03_i686-pc-linux-gnu) which spawns them causes these zombie
> cp things to get reaped.

I believe this is not related. Just a bug in the program missing
SIGCHLD and not calling waitpid.
