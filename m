Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbRFLPDU>; Tue, 12 Jun 2001 11:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRFLPDL>; Tue, 12 Jun 2001 11:03:11 -0400
Received: from smtpde01.sap-ag.de ([194.39.131.52]:34449 "EHLO
	smtpde01.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261679AbRFLPDD>; Tue, 12 Jun 2001 11:03:03 -0400
From: Christoph Rohland <cr@sap.com>
To: Peter Niemayer <niemayer.viag@isg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unused shared memory is written into core dump - bug or feature?
In-Reply-To: <3B262158.29EFC01A@isg.de>
Organisation: SAP LinuxLab
Date: 12 Jun 2001 16:56:29 +0200
In-Reply-To: Peter Niemayer's message of "Tue, 12 Jun 2001 16:04:08 +0200"
Message-ID: <m3ae3d7nmq.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 12 Jun 2001, Peter Niemayer wrote:
> I just noticed that when I attach some SYSV shared memory segments
> to my process and then that process dies from a SIGSEGV that _all_
> the shared memory is dumped into the core file, even if it was never
> used and therefore didn't show up in any of the memory statistics.

Fixed in recent kernel versions (2.2 and 2.4). It will create sparse
files and not touch the unused address space.

Greetings
		Christoph


