Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSBZNrC>; Tue, 26 Feb 2002 08:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSBZNqv>; Tue, 26 Feb 2002 08:46:51 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:58051 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S286161AbSBZNqq>; Tue, 26 Feb 2002 08:46:46 -0500
From: Christoph Rohland <cr@sap.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SHM_LOCK question
In-Reply-To: <200202252136.g1PLaWs25602@eng2.beaverton.ibm.com>
Organisation: SAP LinuxLab
Date: Tue, 26 Feb 2002 14:46:37 +0100
In-Reply-To: <200202252136.g1PLaWs25602@eng2.beaverton.ibm.com> (Badari
 Pulavarty's message of "Mon, 25 Feb 2002 13:36:32 -0800 (PST)")
Message-ID: <m3heo49wzm.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari,

On Mon, 25 Feb 2002, Badari Pulavarty wrote:
> I am trying to understand how SHM_LOCK works on 2.4.17.
> All I can see SHM_LOCKED set in shm_flags. I don't see how 
> it is locking the pages (that are already existing or future 
> pages). Can somebody explain ?

This flag prevents that the pages are written to swap. shmem_writepage
honors it. SHM_LOCK does _not_ force actually swapped out pages into
memory though.

Greetings
		Christoph


