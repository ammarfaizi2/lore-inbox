Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268959AbUIQTcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268959AbUIQTcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 15:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIQTcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 15:32:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:13070 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268957AbUIQTci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 15:32:38 -0400
Date: Fri, 17 Sep 2004 20:31:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ray Bryant <raybry@sgi.com>
Cc: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>,
       lse-tech@lists.sourceforge.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] lockmeter: fixes
Message-ID: <20040917203158.A16855@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
	Andrew Morton <akpm@osdl.org>, lse-tech@lists.sourceforge.net,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com> <20040917083127.F10537@infradead.org> <414B3270.2080409@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <414B3270.2080409@sgi.com>; from raybry@sgi.com on Fri, Sep 17, 2004 at 01:52:32PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I'll take a look at it as soon as I get done chasing the COOL bits changes.
> 
> Is there a specific example you can point me at as to how others have done this?

Just grep for create_proc_entry - lots of drivers are using this.  In fact I wonder
whether a miscdevice wouldn't be the better choice for lockmeter, but given that'd
need userland changes let's stay away from that for now.
