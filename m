Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSARVzm>; Fri, 18 Jan 2002 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290848AbSARVzc>; Fri, 18 Jan 2002 16:55:32 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:47627 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290843AbSARVzX>; Fri, 18 Jan 2002 16:55:23 -0500
Date: Fri, 18 Jan 2002 21:55:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dan Malek <dan@embeddededge.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent from interrupt == BAD
Message-ID: <20020118215515.K2059@flint.arm.linux.org.uk>
In-Reply-To: <20020118130209.J14725@altus.drgw.net> <3C4875DB.9080402@embeddededge.com> <20020118.123221.85715153.davem@redhat.com> <20020118212949.H2059@flint.arm.linux.org.uk> <3C4897BD.1080503@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C4897BD.1080503@embeddededge.com>; from dan@embeddededge.com on Fri, Jan 18, 2002 at 04:46:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC list trimmed)

On Fri, Jan 18, 2002 at 04:46:37PM -0500, Dan Malek wrote:
> Russell King wrote:
> > ..... The problem currently is
> > that there is no way for the page table allocation functions to know
> > that they should be using atomic and emergency pool memory allocations.
> 
> Hmmm...I thought they already do this.  I always assumed the gfp_flag passed
> into alloc_pages would find its way all of the way through the page table
> allocation as well.  You just have to be ready to handle the case where
> it returns with an -ENOMEM :-).

I refer you to your nearest function prototype for pte_alloc_one()
rather than alloc_pages().

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

