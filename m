Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290842AbSARVrm>; Fri, 18 Jan 2002 16:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290846AbSARVrc>; Fri, 18 Jan 2002 16:47:32 -0500
Received: from host155.209-113-146.oem.net ([209.113.146.155]:38902 "EHLO
	tibook.netx4.com") by vger.kernel.org with ESMTP id <S290842AbSARVrP>;
	Fri, 18 Jan 2002 16:47:15 -0500
Message-ID: <3C4897BD.1080503@embeddededge.com>
Date: Fri, 18 Jan 2002 16:46:37 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.11-pre6-ben0 ppc; en-US; 0.8) Gecko/20010419
X-Accept-Language: en
MIME-Version: 1.0
CC: hozer@drgw.net, linux-kernel@vger.kernel.org, groudier@free.fr
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <20020118130209.J14725@altus.drgw.net> <3C4875DB.9080402@embeddededge.com> <20020118.123221.85715153.davem@redhat.com> <20020118212949.H2059@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> ..... The problem currently is
> that there is no way for the page table allocation functions to know
> that they should be using atomic and emergency pool memory allocations.

Hmmm...I thought they already do this.  I always assumed the gfp_flag passed
into alloc_pages would find its way all of the way through the page table
allocation as well.  You just have to be ready to handle the case where
it returns with an -ENOMEM :-).


	-- Dan

