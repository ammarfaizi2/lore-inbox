Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDUW6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDUW6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDUW6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:58:41 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:19421 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750704AbWDUW6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:58:41 -0400
Subject: RE: kfree(NULL)
From: Daniel Walker <dwalker@mvista.com>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, jmorris@namei.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <000e01c66596$66961750$853d010a@nuitysystems.com>
References: <000e01c66596$66961750$853d010a@nuitysystems.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 15:58:38 -0700
Message-Id: <1145660319.20843.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 15:53 -0700, Hua Zhong wrote:
> > struct likeliness {
> > 	char *file;
> > 	int line;
> > 	atomic_t true_count;
> > 	atomic_t false_count;
> > 	struct likeliness *next;
> > };
> 
> It seems including atomic.h inside compiler.h is a bit tricky (might have interdependency).
> 
> Can we just live with int instead of atomic_t? We don't really care about losing a count occasionally..

It's nice so you don't have to fool around with locking .. The atomic_t
structure is pretty simple thought . I think it boils down to just an
int anyway .

Daniel

