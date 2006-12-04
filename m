Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937168AbWLDVnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937168AbWLDVnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937406AbWLDVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:43:50 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:37292 "EHLO
	ms-smtp-02.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937205AbWLDVnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:43:50 -0500
Message-Id: <200612042143.kB4LhSXl003707@ms-smtp-02.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>
Cc: "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Mon, 4 Dec 2006 15:43:27 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <200612041846.kB4Ikx2F026455@laptop13.inf.utfsm.cl>
Thread-Index: AccX1KRHYKtF/WIRSJSKNQ4Fi6O8UQAFpGtw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Horst H. von Brand [mailto:vonbrand@inf.utfsm.cl]
> How do you /know/ it won't just be recycled in the production case?

In the production case is when oom fires and kills things. I can only assume
memory is not being freed fast enough otherwise oom wouldn't get so upset.

> That is your ultimate goal, not what you are doing, step by step.

It's 1/2+ million lines of code, there are a lot of steps. Other than saying
we create a 1.6GB shared memory segment up front, then load the high
availability iSCSI application, start I/O with some number of clients and
then launch an update. I'm not sure what detail you're looking for. Linus
seems to have the best summary of the problem so far saying that we have a
2GB system with 1.6GB dedicated and we want the OS to pretend there's only
400MB of memory.


