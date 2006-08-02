Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWHBSe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWHBSe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWHBSe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:34:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932128AbWHBSe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:34:29 -0400
Date: Wed, 2 Aug 2006 14:37:09 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060802183709.GJ3435@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> There is one outstanding issue where I am probably requiring too much alignment
> on the arch/i386 kernel.  

There was posts awhile ago about optimizing the kernel performance by
loading it at a 4MB offset.  

http://www.lkml.org/lkml/2006/2/23/189

Your changes breaks that on i386 (not aligned on a 4MB boundary).  But a
5MB offset works.  Is that the correct update or does that break the
original idea?

Cheers,
Don
