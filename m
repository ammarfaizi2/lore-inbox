Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUINMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUINMMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbUINMKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:10:40 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:20178 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S269370AbUINMI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:08:58 -0400
Date: Tue, 14 Sep 2004 14:08:06 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>
Subject: Re: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines
Message-ID: <20040914120805.GA17333@k3.hellgate.ch>
Mail-Followup-To: Lars Marowsky-Bree <lmb@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com> <20040914023114.GQ9106@holomorphy.com> <20040914105527.GB11238@k3.hellgate.ch> <20040914111024.GN4882@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914111024.GN4882@marowsky-bree.de>
X-Operating-System: Linux 2.6.9-rc2-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 13:10:24 +0200, Lars Marowsky-Bree wrote:
> On 2004-09-14T12:55:27,
>    Roger Luethi <rl@hellgate.ch> said:
> 
> > > -#define PID_MAX_LIMIT (4*1024*1024)
> > > +#define PID_MAX_LIMIT (sizeof(long) > 32 ? 4*1024*1024 : PID_MAX_DEFAULT)
> > An architecture with sizeof(long) > 32? -- Most impressive.
> 
> x86_64, s390x, ppc64...

Really.
