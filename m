Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTJUX33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTJUX33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 19:29:29 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28171
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263400AbTJUX31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 19:29:27 -0400
Subject: Re: 2.6.0-test8-mm1
From: Robert Love <rml@tech9.net>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: James Simmons <jsimmons@infradead.org>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <200310220053.13547.schlicht@uni-mannheim.de>
References: <Pine.LNX.4.44.0310212141290.32738-100000@phoenix.infradead.org>
	 <200310220053.13547.schlicht@uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1066778844.768.348.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 21 Oct 2003 19:27:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 18:53, Thomas Schlichter wrote:

> For me the big question stays why enabling the DEBUG_* options results in a 
> corrupt cursor and the false dots on the top of each row... (with both 
> kernels)

Almost certainly due to CONFIG_DEBUG_SLAB or CONFIG_DEBUG_PAGEALLOC,
which debug memory allocations and frees.

Code that commits the usual memory bugs (use-after-free, etc.) will
quickly die with these set, whereas without them the bug might never
manifest.

	Robert Love


