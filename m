Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751938AbWFLM4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbWFLM4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWFLM4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:56:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:29530 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751938AbWFLM4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:56:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+7LAlmFzux6eHfM5v3C+FN/2yYAi8EnCrbJtenukWXkWJoKOV8L1Y+1sFYaaN3s9gUbKyY3/9kSNOuNifaXrijcLrrwqZ0rtom3TVmX1QGkK6XjBLjC66yolmgRzzNwQuD92BpzPFHT8DDGBLN0zvHfBEifgf3Q9q7DZoIJvyg=
Message-ID: <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
Date: Mon, 12 Jun 2006 13:56:11 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20060612105345.GA8418@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> What i'd like to see though are clear explanations about why an
> allocation is not considered a leak, in terms of comments added to the
> code. That will also help us reduce the number of annotations later on.

I'll document them in both Documentation/kmemleak.txt and inside the
code. If I implement the "any pointer inside the block" method, all
the memleak_padding() false positives will disappear.

-- 
Catalin
