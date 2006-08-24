Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWHXS0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWHXS0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWHXS0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:26:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33480 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030435AbWHXS0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:26:49 -0400
Date: Thu, 24 Aug 2006 11:26:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dong Feng <middle.fengdong@gmail.com>
cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Unnecessary Relocation Hiding?
In-Reply-To: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, Dong Feng wrote:

> I have a question. Why shall we need a RELOC_HIDE() macro in the
> definition of per_cpu()? Maybe the question is actually why we need
> macro RELOC_HIDE() at all. I changed the following line in
> include/asm-generic/percpu.h, from

Guess it was copied from IA64 but the semantics were not preserved.
I think it should either be changed the way you suggest or the 
implementation needs to be fixed to actually do a linker relocation.
