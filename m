Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWAXSbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWAXSbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWAXSbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:31:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58542 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932482AbWAXSbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:31:14 -0500
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060124181945.GA21955@deprecation.cyrius.com>
References: <20060124181945.GA21955@deprecation.cyrius.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 19:31:12 +0100
Message-Id: <1138127472.2977.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 18:19 +0000, Martin Michlmayr wrote:
> Currently, modular input support fails to load with the following error:
> 
> qube:# modprobe input
> input: Unknown symbol kobject_get_path
> input: Unknown symbol add_input_randomness
> 
> In the short run, this can be solved by exporting these two symbols.
> There have been discussions about fixing this in a different manner,
> see http://www.ussg.iu.edu/hypermail/linux/kernel/0505.2/1068.html
> Since this was in the days of 2.6.12-rc4 and modular input support is
> still broken, I suggest these symbols to be exported for now.


better make these _GPL exports to make sure people understand these are
internal things...


