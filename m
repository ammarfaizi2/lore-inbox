Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUEFVgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUEFVgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUEFVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:36:45 -0400
Received: from emess.mscd.edu ([147.153.170.17]:3020 "EHLO emess.mscd.edu")
	by vger.kernel.org with ESMTP id S262079AbUEFVgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:36:44 -0400
From: Steve Beaty <beaty@emess.mscd.edu>
Message-Id: <200405062136.i46La83a017507@emess.mscd.edu>
Subject: Re: sigaction, fork, malloc, and futex
To: chris@scary.beasts.org
Date: Thu, 6 May 2004 15:36:08 -0600 (MDT)
Cc: beaty@emess.mscd.edu (Steve Beaty), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0405042315001.24297@sphinx.mythic-beasts.com> from "chris@scary.beasts.org" at May 04, 2004 11:30:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your signal handler function is illegally calling non-reentrant functions.
> The *printf() family of functions are going to need to call malloc() to
> allocate buffers. malloc() cannot be re-entered.

	it deadlocks even with no calls in the client...  weird.

	thanks,

-- 
Dr. Steve Beaty (B80)                                 Associate Professor
Metro State College of Denver                        beaty@emess.mscd.edu
VOX: (303) 556-5321                                 Science Building 134C
FAX: (303) 556-5381                         http://clem.mscd.edu/~beatys/
