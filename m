Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTFIOGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTFIOGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:06:09 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:16395 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264328AbTFIOGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:06:07 -0400
Date: Mon, 9 Jun 2003 15:19:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: 2.5 kbuild: use of '-z muldefs' for LD?
Message-ID: <20030609151945.A10352@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jaroslav Kysela <perex@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	"kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>
References: <20030609130438.A6417@infradead.org> <Pine.LNX.4.44.0306091550000.1323-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306091550000.1323-100000@pnote.perex-int.cz>; from perex@suse.cz on Mon, Jun 09, 2003 at 04:01:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 04:01:41PM +0200, Jaroslav Kysela wrote:
> But this solution will create a new kernel module. The shared code is 
> really small and having small codes in separated modules is waste of 
> memory in my eyes.

Well, if you want separate copies of it you have to make sure the
symbols won't clash, e.g. calling all functions in it

MYPREFIX_foo

and then do #define MYPREFIX	KBUILD_MODNAME

or something like that
