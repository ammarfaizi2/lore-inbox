Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWAFVzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWAFVzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWAFVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:55:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48083 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932577AbWAFVzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:55:41 -0500
Subject: Re: [patch 0/4] Series to allow a "const" file_operations struct
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1136583937.2940.90.camel@laptopd505.fenrus.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 22:55:39 +0100
Message-Id: <1136584539.2940.105.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 22:45 +0100, Arjan van de Ven wrote:
> Hi,
> 
> this series allows drivers to have "const" file_operations, by making
> the f_ops field in the inode const. This has another benefit, there have

ok there was a sentence missing here. The first benefit is that this
moves these hot datastructures to the rodata section, which means they
won't accidentally be doing false cacheline sharing.


