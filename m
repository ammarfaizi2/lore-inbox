Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVEPJbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVEPJbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVEPJbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:31:36 -0400
Received: from main.gmane.org ([80.91.229.2]:26022 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261507AbVEPJbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:31:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Mon, 16 May 2005 11:29:10 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.16.09.29.09.407174@smurf.noris.de>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adam J. Richter wrote:

> 	Being able to do without a server side CGI script might
> encourage deployment a bit more, both for security reasons and
> effort of deployment.

A simple server-side CGI would be a "send me all changeset SHA-1s,
starting at HEAD until you reach FOO" operation (FOO being the SHA1 of
the previous head you've pulled before). This operation is simple enough
that it people should have no problem installing such a CGI.

You could then stream-pull the actual contents over HTTP/1.1 without
further CGI interaction.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


