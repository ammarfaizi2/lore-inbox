Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264833AbSJVUwh>; Tue, 22 Oct 2002 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbSJVUwg>; Tue, 22 Oct 2002 16:52:36 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9915 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264833AbSJVUwf>; Tue, 22 Oct 2002 16:52:35 -0400
Subject: Re: NatSemi Geode improvement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hiroshi Miura <miura@da-cha.org>
Cc: davej@suse.de, hpa@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
In-Reply-To: <20021018022901.CA2D811782A@triton2>
References: <20021017171217.4749211782A@triton2>
	<20021017192041.B17285@suse.de>  <20021018022901.CA2D811782A@triton2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 22:14:52 +0100
Message-Id: <1035321292.31979.157.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 03:29, Hiroshi Miura wrote:
> I try now using set6x86 to set these registers, then can do most of these 
> except for set_cx86_memwb().

I think the original patch was the best, setting sensible defaults - as
we can make that code __init so it is free. I merged the other fixes and
made the GEODE CPU choice set OOSTORE. That means what is needed now is
to drop in the code to set the CPU to writeback, and also the code to
check that the mmio space is actually beyond 1Gbyte

