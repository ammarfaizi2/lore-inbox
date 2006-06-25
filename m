Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWFYVo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWFYVo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWFYVo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:44:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49843 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750869AbWFYVo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:44:56 -0400
Subject: Re: remove __read_mostly?
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060625115736.d90e1241.akpm@osdl.org>
References: <20060625115736.d90e1241.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 23:44:49 +0200
Message-Id: <1151271890.4940.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 11:57 -0700, Andrew Morton wrote:
> I'm thinking we should remove __read_mostly.
> 
> Because if we use this everywhere where it's supposed to be used, we end up
> with .bss and .data 100% populated with write-often variables, packed
> closely together.  The cachelines will really flying around.


one thing we could/should do is have a "written during boot only"
section; which we then can mark read only as well :)


