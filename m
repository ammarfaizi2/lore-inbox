Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWAQPBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWAQPBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWAQPBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:01:11 -0500
Received: from silver.veritas.com ([143.127.12.111]:41078 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751239AbWAQPBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:01:00 -0500
Date: Tue, 17 Jan 2006 15:01:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Akinobu Mita <mita@miraclelinux.com>
cc: Keith Owens <kaos@ocs.com.au>, ak@suse.de, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 3/4] compact print_symbol() output
In-Reply-To: <20060117112318.GA24671@miraclelinux.com>
Message-ID: <Pine.LNX.4.61.0601171453270.6403@goblin.wat.veritas.com>
References: <20060117101555.GD19473@miraclelinux.com> <10099.1137494043@ocs3.ocs.com.au>
 <20060117112318.GA24671@miraclelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Jan 2006 15:01:00.0267 (UTC) FILETIME=[D3F35BB0:01C61B76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Akinobu Mita wrote:
> 
> And do you have any objection to remove symbolsize output in
> print_symbol()? I can't find useful usage about symbolsize in
> print_symbol() except to do a double check that the oops is
> matching the vmlinux we're looking at. (so I made 4/4)
> Do you know any useful usage about symbolsize?

I've often found symbolsize useful.  Not when looking at an oops
from my own machine.  But when looking at an oops posted on LKML,
from someone who most likely has a different .config and different
compiler, different optimization and different inlining from mine.
symbolsize is a good clue as to how close their kernel is to the
one I've got built on my machine, how likely guesses I make based
on mine will apply to theirs, and whereabouts in the function that
it oopsed.

Hugh
