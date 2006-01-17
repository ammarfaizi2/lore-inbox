Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWAQKbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWAQKbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWAQKbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:31:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1974 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932331AbWAQKbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:31:32 -0500
Subject: Re: [PATCH 0/4] compact call trace
From: Arjan van de Ven <arjan@infradead.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <20060117101339.GA19473@miraclelinux.com>
References: <20060117101339.GA19473@miraclelinux.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 11:31:27 +0100
Message-Id: <1137493887.3005.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 19:13 +0900, Akinobu Mita wrote:
> These patches will:
> 
> - break the various custom oops-parsers which people have written themselves.
> - use common call trace format on x86-64.
> - change offset format from hexadecimal to decimal in print_symbol()
> - delete symbolsize in call trace in print_symbol().
> - print system_utsname.version in oops so that we can doing a
>   double check that the oops is matching the vmlinux we're looking at.


at least then make the kallsyms lookup mark up the string somehow (say
by putting a * in front of it) if the EIP is outside the size of the
symbol; so that we can spot garbage better.


