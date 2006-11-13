Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755296AbWKMRXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbWKMRXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbWKMRW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:22:59 -0500
Received: from mail.suse.de ([195.135.220.2]:22175 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755226AbWKMRW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:22:58 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC] [PATCH 2/16] x86_64: Assembly safe page.h and pgtable.h
Date: Mon, 13 Nov 2006 18:17:00 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
References: <20061113162135.GA17429@in.ibm.com> <20061113162827.GC17429@in.ibm.com>
In-Reply-To: <20061113162827.GC17429@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131817.01066.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 17:28, Vivek Goyal wrote:
> 
> This patch makes pgtable.h and page.h safe to include
> in assembly files like head.S.  Allowing us to use
> symbolic constants instead of hard coded numbers when
> refering to the page tables.

Hmm, I think the ULs are probably not needed anyways. What
happens when you just drop them even for C? You shouldn't get any 
new warnings i hope.

-Andi
