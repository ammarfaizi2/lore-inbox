Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTFLQlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTFLQlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:41:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264884AbTFLQlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:41:39 -0400
Date: Thu, 12 Jun 2003 09:55:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: dipankar@in.ibm.com, John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <Pine.LNX.4.44.0306120947570.2742-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0306120952440.2742-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jun 2003, Linus Torvalds wrote:
> 
> How about something like this.. It still breaks if the _target_ is 
> unhashed

Actually, it doesn't _break_, it just does something surprising (but 
possibly quite correct): it will hash the dentry to the same hash chain 
the target _used_ to be on before being unhashed. 

Which might actually be the right thing, but it still sounds to me like  
a bad idea to have a unhashed target.

		Linus

