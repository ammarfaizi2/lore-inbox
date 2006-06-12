Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWFLFTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWFLFTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 01:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWFLFTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 01:19:37 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:3434 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751355AbWFLFTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 01:19:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=mUUTXacZ37ELhSPrQwHyny46geJptU8+8vzODRlkJr5CqDQ1hFjQtW3ml30co1xBpCUPcOygCZQI3xKeRbR4Q+VwwqGloc13cL2hh58xMHlovW5YaUakYaeqtgyAin93xKqkGbtAg6GZEEBwdtIfegfPyQVCsWuy602by0zqhwQ=
Message-ID: <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
Date: Mon, 12 Jun 2006 08:19:36 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060611112156.8641.94787.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
X-Google-Sender-Auth: 603ba06c228b7e11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 6/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> There are allocations for which the main pointer cannot be found but they
> are not memory leaks. This patch fixes some of them.

Can we fix this by looking for pointers to anywhere in the allocated
memory block instead of just looking for the start?

                                                     Pekka
