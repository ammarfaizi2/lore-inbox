Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTAOUZb>; Wed, 15 Jan 2003 15:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTAOUZb>; Wed, 15 Jan 2003 15:25:31 -0500
Received: from pop-ls-7-1-dialup-5.freesurf.ch ([194.230.245.5]:3200 "EHLO
	valsheda.taprogge.wh") by vger.kernel.org with ESMTP
	id <S266987AbTAOUZa>; Wed, 15 Jan 2003 15:25:30 -0500
Date: Wed, 15 Jan 2003 21:31:34 +0100
From: jens.taprogge@rwth-aachen.de
To: Yaacov Akiba Slama <ya@slamail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [BUG] cardbus/hotplugging still broken in 2.5.56
Message-ID: <20030115203134.GA2215@valsheda.taprogge.wh>
Mail-Followup-To: jens.taprogge@rwth-aachen.de,
	Yaacov Akiba Slama <ya@slamail.org>, linux-kernel@vger.kernel.org
References: <3E25C0F3.9000208@slamail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E25C0F3.9000208@slamail.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if you have seen the patch I posted on l-k. It should fix
both issues. 

Jens

On Wed, Jan 15, 2003 at 10:13:39PM +0200, Yaacov Akiba Slama wrote:
> Jens Taprogge wrote :
> 
> >You are not freeing the possibly already allocated resources in case of
> >a failure of either pci_assign_resource() or pca_enable_device(). In
> >fact you are not even checking if pci_assign_resource() fails. That
> >seems wrong to me.
> 
> There are two separate issues :
> 1) Fix the "ressource collisions" problem (and irq not known).
> 2) Freeing ressources in case of failure of some functions.
> 
> My patch solves the first issue only in order to make cardbus with rom work.
> The point 2 is a janitor work.
> 
> Thanks,
> Yaacov Akiba Slama

-- 
Jens Taprogge
