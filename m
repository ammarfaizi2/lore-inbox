Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWFYVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWFYVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWFYVw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:52:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57532 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932371AbWFYVw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:52:58 -0400
Subject: Re: remove __read_mostly?
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060625115736.d90e1241.akpm@osdl.org>
References: <20060625115736.d90e1241.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 23:52:53 +0200
Message-Id: <1151272373.4940.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Because if we use this everywhere where it's supposed to be used, we end up
> with .bss and .data 100% populated with write-often variables, packed
> closely together.  The cachelines will really flying around.

this argument is true if you have unrelated data together; however if
related data is together than suddenly you improve and increase cache
density....


