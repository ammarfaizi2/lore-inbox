Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSKCPdM>; Sun, 3 Nov 2002 10:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbSKCPdM>; Sun, 3 Nov 2002 10:33:12 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2349 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262046AbSKCPdL>; Sun, 3 Nov 2002 10:33:11 -0500
Date: Sun, 3 Nov 2002 10:37:10 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@suse.de>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Message-ID: <20021103103710.D10988@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Sun, Nov 03, 2002 at 04:14:26PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 04:14:26PM -0200, Denis Vlasenko wrote:
> Here is the cure: force_inline will guarantee inlining.
> 
> To use _only_ with functions which meant to be almost
> optimized away to nothing but are large and gcc might decide
> they are _too_ large for inlining.

Well, you can as well bump -finline-limit, like -finline-limit=2000.
The default is too low for kernel code (and glibc too).

	Jakub
