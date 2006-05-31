Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWEaCVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWEaCVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 22:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWEaCVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 22:21:11 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:62950 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1751538AbWEaCVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 22:21:09 -0400
Subject: Re: i386 subarchitectures: boot page table flags
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <447CF7F5.8010709@zytor.com>
References: <447CF7F5.8010709@zytor.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 21:21:05 -0500
Message-Id: <1149042065.3545.49.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 18:57 -0700, H. Peter Anvin wrote:
> Does any of the i386 subarchitectures actually care about the Accessed and Dirty bits in 
> the bootup pagetables (the ones that start at pg0, used before the mm is initialized?)  If 
> not, I'd like to speed up booting by setting those bits at initialization time.

Depends what you mean by "care".  I do hijack pg0 in
voyager_memory_detect() to access the clickmap for ascertaining the
memory layout, but I don't use the accessed or dirty bits.

James


