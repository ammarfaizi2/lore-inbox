Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755056AbWKNBvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbWKNBvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbWKNBvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:51:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:11475 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755056AbWKNBvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:51:12 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC] [PATCH 2/16] x86_64: Assembly safe page.h and pgtable.h
Date: Tue, 14 Nov 2006 02:46:28 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
References: <20061113162135.GA17429@in.ibm.com> <200611131817.01066.ak@suse.de> <20061113211636.GC13832@in.ibm.com>
In-Reply-To: <20061113211636.GC13832@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140246.28433.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I think we need these UL suffixes. Otherwise in some cases overflow
> can take place and compiler emits warning.
> 
> For ex. in following definition I got rid of UL.
> 
> #define PGDIR_SIZE      (1 << PGDIR_SHIFT) 

Yes for the shifts it is needed, but not for the unshifted constants.
I think. At least when they're hex the compiler should chose the right
type on its own.

-Andi
