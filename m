Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUINLPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUINLPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUINLMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:12:34 -0400
Received: from gate.in-addr.de ([212.8.193.158]:48560 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269296AbUINLKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:10:34 -0400
Date: Tue, 14 Sep 2004 13:10:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>
Subject: Re: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines
Message-ID: <20040914111024.GN4882@marowsky-bree.de>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com> <20040914023114.GQ9106@holomorphy.com> <20040914105527.GB11238@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914105527.GB11238@k3.hellgate.ch>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-09-14T12:55:27,
   Roger Luethi <rl@hellgate.ch> said:

> > -#define PID_MAX_LIMIT (4*1024*1024)
> > +#define PID_MAX_LIMIT (sizeof(long) > 32 ? 4*1024*1024 : PID_MAX_DEFAULT)
> An architecture with sizeof(long) > 32? -- Most impressive.

x86_64, s390x, ppc64...


