Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWH1HbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWH1HbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWH1HbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:31:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932420AbWH1HbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:31:10 -0400
Subject: Re: Why Semaphore Hardware-Dependent?
From: Arjan van de Ven <arjan@infradead.org>
To: Dong Feng <middle.fengdong@gmail.com>
Cc: ak@suse.de, Paul Mackerras <paulus@samba.org>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 09:30:49 +0200
Message-Id: <1156750249.3034.155.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 03:22 +0800, Dong Feng wrote:
> Why can't we have a hardware-independent semaphore definition while we
> have already had hardware-dependent spinlock, rwlock, and rcu lock? It
> seems the semaphore definitions classified into two major categories.
> The main deference is whether there is a member variable _sleeper_.

btw semaphores are a deprecated construct mostly; mutexes are the way to
go for new code if they fit the usage model of mutexes. And mutexes are
indeed generic (with a architecture hook to allow a specific operation
to be optimized using assembly)


