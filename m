Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWFLIRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWFLIRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWFLIRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:17:21 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:28097 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750808AbWFLIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:17:20 -0400
Date: Mon, 12 Jun 2006 11:17:18 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Catalin Marinas <catalin.marinas@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
In-Reply-To: <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> 
 <20060611112156.8641.94787.stgit@localhost.localdomain> 
 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > Can we fix this by looking for pointers to anywhere in the allocated
> > memory block instead of just looking for the start?

On Mon, 12 Jun 2006, Catalin Marinas wrote:
> I thought about this as well (I think that's how Valgrind works) but
> it would increase the chances of missing real leaks.

Yeah but that's far better than adding bunch of 'not a leak' annotations 
around the kernel which is very impractical to maintain.  I would like to 
see your leak detector in the kernel so we can finally get rid of all 
those per-subsystem magic allocators.  This patch, however, is 
unacceptable for inclusion IMHO.

				Pekka
