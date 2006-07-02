Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWGBSqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWGBSqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWGBSqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:46:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51640 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932668AbWGBSqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:46:24 -0400
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       Edgar Hucek <hostmaster@ed-soft.at>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
References: <44A04F5F.8030405@ed-soft.at>
	 <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	 <44A0CCEA.7030309@ed-soft.at>
	 <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org> <44A304C1.2050304@zytor.com>
	 <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com> <44A8058D.3030905@zytor.com>
	 <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 20:46:12 +0200
Message-Id: <1151865973.3111.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Although I am surprised we could not just make that query by looking
> at the resources.  Possibly we are too early in boot.

the problem in this specific case is that you try to compare the
resource info (more or less, indirectly) to the memory map, and abort if
there's a discrepancy, as a sanity check against b0rked bioses. 

