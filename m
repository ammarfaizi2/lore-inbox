Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWGATmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWGATmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 15:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWGATmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 15:42:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50141 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751918AbWGATmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 15:42:24 -0400
Subject: Re: [patch 0/2] sLeAZY FPU feature
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
In-Reply-To: <44A6B387.80207@yahoo.com.au>
References: <1151773893.3195.45.camel@laptopd505.fenrus.org>
	 <44A6B387.80207@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 21:42:22 +0200
Message-Id: <1151782942.3195.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 03:40 +1000, Nick Piggin wrote:

> What sort of test?

the one I did was long running FPU app (calculating PI using FPU)

>  Any idea of the results for a best case microbenchmark
> (something like two threads ping-pong a couple of futexes between them,
> in between doing a single FPU op)

ok I wrote a test scenario for this; the performance gain I get with
this is 8.5% 

the FPU part of the hot loop I used is
                A = 0.3 * (A+B);
with A and B doubles



