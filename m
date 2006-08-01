Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWHAJj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWHAJj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWHAJj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:39:28 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:61454 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932593AbWHAJj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:39:27 -0400
Subject: RE: do { } while (0) question
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Jiri Slaby'" <jirislaby@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
In-Reply-To: <008e01c6b549$59e52f70$493d010a@nuitysystems.com>
References: <008e01c6b549$59e52f70$493d010a@nuitysystems.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 11:39:31 +0200
Message-Id: <1154425171.32739.2.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 02:03 -0700, Hua Zhong wrote:
> > #if KILLER == 1
> > #define MACRO
> > #else
> > #define MACRO do { } while (0)
> > #endif
> > 
> > {
> > 	if (some_condition)
> > 		MACRO
> > 
> > 	if_this_is_not_called_you_loose_your_data();
> > }
> > 
> > How do you want to define KILLER, 0 or 1? I personally choose 0.
> 
> Really? Does it compile?

No, and that is the whole point.

The empty 'do {} while (0)' makes the missing semicolon a syntax error.


