Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUC1Rbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUC1Rbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:31:44 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:38802 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S262063AbUC1RbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:31:19 -0500
Message-ID: <40670BAE.4060901@steudten.com>
Date: Sun, 28 Mar 2004 19:30:22 +0200
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Norbert Preining <preining@logic.at>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, mingo@redhat.com,
       neilb@cse.unsw.edu.au
Subject: Re: md raid oops on 2.4.25/alpha
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at> <20040327164153.GA7324@gamma.logic.tuwien.ac.at> <20040328160246.GA19965@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040328160246.GA19965@gamma.logic.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the well known bad assembler code with gcc.
On the alpha you see the problem first in the
raid1_read_balance() code sequence..
You should use gcc 3.3.2 better 3.3.3.
For alpha find the binary rpms here:
http://www.steudten.org/alpha/packages/

Tom

Norbert Preining wrote:
> Hi Ingo, hi Neil, hi lists!
> 
> We have some problems with the md code on alpha. We get regular oops
> when using the md raid1. Here we got another oops when fsck (at boot 
> time) the raid:
> This was after a fresh reboot. As long as only the raid is *not* mounted
> of fsck the machine works without any oops.
> 
> I also can mount the hard disks *without* raid directly as hda1 and
> hdc1, and do NOT get any errors here, so I suspect that only the md code
> is the culprit.

>>>RA;  fffffc00004a8d7c <raid1_make_request+1dc/480>
> 
> 
>>>PC;  fffffc00004a8aa4 <raid1_read_balance+104/200>   <=====

