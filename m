Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTKORSq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 12:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTKORSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 12:18:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56543 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261869AbTKORSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 12:18:45 -0500
Date: Sat, 15 Nov 2003 17:18:44 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Harald Welte <laforge@netfilter.org>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115171843.GN24159@parcelfarce.linux.theplanet.co.uk>
References: <20031114204212.GK6937@obroa-skai.de.gnumonks.org> <Pine.LNX.4.44.0311142059560.849-100000@einstein.homenet> <20031115093833.GB656@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115093833.GB656@obroa-skai.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 10:38:33AM +0100, Harald Welte wrote:
> that doesn't help.  As I am aware, the seq_file structure is only
> allocated in the seq_open() call.  How does seq_open() know which
> private data (i.e. hash table) to associate with struct file?

Why should seq_open() know that?  Its caller does and it can set the damn
thing to whatever it wants.

> The only moment I know which htable corresponds to a proc entry is at
> the time where I call proc_net_create() [or a similar function].  So the
> information would need to be associated with the dentry or whatever...
> seq_file() is allocated way too late.

Wrong.
