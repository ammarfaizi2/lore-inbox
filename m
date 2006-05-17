Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWEQLSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWEQLSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 07:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWEQLSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 07:18:45 -0400
Received: from e-nvb.com ([69.27.17.200]:57521 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S1751267AbWEQLSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 07:18:45 -0400
Subject: Re: swapper_space export
From: Arjan van de Ven <arjan@infradead.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
References: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:18:25 +0200
Message-Id: <1147864721.3051.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 19:24 -0400, Josef Sipek wrote:
> I was trying to compile the Unionfs[1] to get it up to sync it up with
> the kernel developments from the past few months. Anyway, long story
> short...swapper_space (defined in mm/swap_state.c) is not exported
> anymore (git commit: 4936967374c1ad0eb3b734f24875e2484c3786cc). This
> apparently is not an issue for most modules. Troubles arise when the
> modules include mm.h or any of its relatives.
> 
> One simply gets a linker error about swapper_space not being defined.
> The problem is that it is used in mm.h.


don't you think it's really suspect that no other filesystem, in fact no
other driver in the kernel needs this? Could it just be that unionfs is 
using a wrong API ? Because if that's the case you're patch is just the
wrong thing. Maybe the unionfs people should try to submit their code
for review etc......

